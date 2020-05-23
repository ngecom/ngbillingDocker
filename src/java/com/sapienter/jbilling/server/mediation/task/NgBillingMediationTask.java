package com.sapienter.jbilling.server.mediation.task;

import com.sapienter.jbilling.common.FormatLogger;
import com.sapienter.jbilling.server.item.PricingField;
import com.sapienter.jbilling.server.item.db.AssetDTO;
import com.sapienter.jbilling.server.item.tasks.SubscriptionResult;
import com.sapienter.jbilling.server.order.OrderBL;
import com.sapienter.jbilling.server.order.db.OrderDTO;
import com.sapienter.jbilling.server.order.db.OrderLineDTO;
import com.sapienter.jbilling.server.user.UserBL;
import com.sapienter.jbilling.server.user.UserWS;
import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.*;

/**
 * @author Rakesh Sahadevan	
 * @Since 04/04/2017
 */
public class NgBillingMediationTask extends AbstractResolverMediationTask {

    private static final FormatLogger LOG = new FormatLogger(TestMediationTask.class);
    private HashMap userMap = new HashMap();

    public HashMap getUserMap() {
		return userMap;
	}

	public void setUserMap() {
		userMap.clear();
		UserBL user = new UserBL();
		List<UserWS> userWS = user.getAllUserWSWithOutContact(getEntityId());
		for(int i=0;i<userWS.size();i++){
			UserWS userDTO  = userWS.get(i);
			  Iterator paramIterator=  parameters.keySet().iterator(); 
		        while(paramIterator.hasNext()){
		        	String subscription = (String)paramIterator.next();
		        	 if (!StringUtils.isBlank(subscription)){
		        		 SubscriptionResult sub = new SubscriptionResult(userDTO.getUserId(), new Integer(subscription)); // SubscriptionItemId
		        			if(sub.isSubscribed()) {
                                String values = parameters.get(subscription);
                                String[] itemId = values.split(",");
                                userDTO.setVoiceItemId(new Integer(itemId[0]));
                                userDTO.setMainSubscriptionId(new Integer(subscription));
                                OrderLineDTO orderLineDTO = sub.getOrderLineDTO();
                                Set<AssetDTO> assetSets = orderLineDTO.getAssets();
                                for(AssetDTO asset : assetSets){
                                    asset.getIdentifier();
                                }
                           		userMap.put(userDTO.getUserName(), userDTO);
		        				break;
		        			}
		        }
		}
	 }
	}		

	@Override
    public void resolveUserCurrencyAndDate(MediationResult result, List<PricingField> fields) {
        // resolve user
        PricingField userField = find(fields, "username"); //asterisk.xml

        if (null != userField) {
           	UserWS userDTO = (UserWS) userMap.get(userField.getStrValue());
            if (null != userDTO) {
                result.setUserId(userDTO.getUserId());
                result.setUserName(userField.getStrValue());
                result.setCurrencyId(userDTO.getCurrencyId());
                result.setMainSubscriptionId(userDTO.getMainSubscriptionId());
            }else{
          		 result.setDone(true);
                 result.addError("ERR-NOUSERSUBSCRIPTION");
                 LOG.debug("Invalid Subscription " + result.getRecordKey());
                 return;
        	 }

        }

        // resolve event date
        PricingField eventDateField = find(fields, "event_date"); //asterisk.xml
        if (null != eventDateField) result.setEventDate(eventDateField.getDateValue());

    }

    @Override
    public boolean isActionable(MediationResult result, List<PricingField> fields) {

        PricingField quantityField = find(fields, "duration");
        if (null == quantityField || quantityField.getIntValue().intValue() < 0||quantityField.getIntValue().intValue()>14000) {
            result.setDone(true);
            result.addError("ERR-DURATION");
            //LOG.debug("Invalid Duration " + result.getRecordKey());
            return false;
        }

        // validate that we were able to resolve the billable user, currency and date
        if (null == result.getCurrentOrder()) {
            if (null != result.getUserId()
                    && null != result.getCurrencyId()
                    && null != result.getEventDate()) {
            	
                OrderDTO currentOrder = OrderBL.getOrCreateCurrentOrder(result.getUserId(),
                        result.getEventDate(),
                        result.getCurrencyId(),
                        result.getPersist());

                result.setCurrentOrder(currentOrder);

                //LOG.debug("Actionable Result " + result.getId() + ", pending action...");
                return true;
            }
        }

        //LOG.debug("Mediation result " + result.getId() + " cannot be processed!");
        return false;
    }

    @Override
    public void doEventAction(MediationResult result, List<PricingField> fields) {

        //LOG.debug("Before Subscription Result--->"+System.currentTimeMillis());
        UserWS userDTO = (UserWS) userMap.get(result.getUserName());
        PricingField destination = find(fields, "description");
        if(userDTO!=null){
                PricingField duration = find(fields, "duration");
                OrderLineDTO line = newLine(userDTO.getVoiceItemId(), convertSecondsToMinutes(adjustDuration(duration.getIntValue(), result.getUserName())));
        	    result.getLines().add(line);
        	    if(destination!=null) {
                    result.setDescription(destination.getStrValue());
                }
			     //LOG.debug("After Subscription Result--->"+System.currentTimeMillis());
        }else{
   		 result.setDone(true);
         result.addError("ERR-PRODUCT");
         LOG.debug("Invalid Duration " + result.getRecordKey());
         return;
	 }

        //If subscribed add in the Line Mediation Result and setprice for Line
    }
    
//    private int adjustDuration(Integer duration, String userName){
//    	  int INCREMENT = 15;
//    	  //UserBL bl = new UserBL(new Integer(userId));
//    	  UserWS userDTO = (UserWS) userMap.get(userName);
//    	  int MIN_DURATION = userDTO.getMinimumRatingTime();
//    	  if(duration<=MIN_DURATION) {
//    	  	return (int)(Math.ceil((double)duration / MIN_DURATION) * MIN_DURATION);
//    	  }else{
//    	  	return (int)(Math.ceil((double)duration / INCREMENT) * INCREMENT);
//    	  }
//    	}

    private int adjustDuration(Integer duration, String userName){
        UserWS userDTO = (UserWS) userMap.get(userName);
        int MIN_DURATION = 15;
        return (int)(Math.ceil((double)duration / MIN_DURATION) * MIN_DURATION);
    }

    private BigDecimal convertSecondsToMinutes(int seconds) {
    	  return new BigDecimal(seconds).divide(new BigDecimal("60"),MathContext.DECIMAL32);
    	}
}
