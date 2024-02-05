package com.sapienter.jbilling.suretax.engine.test;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import junit.framework.TestCase;

import com.sapienter.jbilling.common.SessionInternalError;
import com.sapienter.jbilling.server.item.ItemDTOEx;
import com.sapienter.jbilling.server.metafields.MetaFieldValueWS;
import com.sapienter.jbilling.server.order.OrderWS;
import com.sapienter.jbilling.server.pluggableTask.admin.PluggableTaskWS;
import com.sapienter.jbilling.server.process.db.PeriodUnitDTO;
import com.sapienter.jbilling.server.process.task.SureTaxCompositionTask;
import com.sapienter.jbilling.server.user.UserWS;
import com.sapienter.jbilling.server.util.ServerConstants;
import com.sapienter.jbilling.server.util.api.JbillingAPI;
import com.sapienter.jbilling.server.util.api.JbillingAPIException;
import com.sapienter.jbilling.server.util.api.JbillingAPIFactory;
import com.sapienter.jbilling.test.CreateObjectUtil;

public class NegativeSuretaxTestTwo extends DefaultTest {

	// String origClientNumber = null;

	public void setUp() throws Exception {
		super.setUp();
	}

	@Override
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testWrongPluginParameters() throws JbillingAPIException,
			IOException {
		long currentTimeMillis = System.currentTimeMillis();
		UserWS user = SureTaxCompositionTaskTest.createUser(currentTimeMillis,
				"");
		// Create an item with wrong Transaction Type code
		Integer itemId1 = CreateObjectUtil.createItem(
				"Long Distance Call intra-state", "1.5",
				currentTimeMillis + "", "2201", api);
		ItemDTOEx item1 = api.getItem(itemId1, null, null);
		MetaFieldValueWS[] metaFields = new MetaFieldValueWS[1];
		MetaFieldValueWS transTypeMetaField = new MetaFieldValueWS();
		transTypeMetaField.setStringValue("010101");
		transTypeMetaField.setFieldName("Transaction Type Code");
		metaFields[0] = transTypeMetaField;
		item1.setMetaFields(metaFields);
		api.updateItem(item1);
		// purchase order with taxable items
		Calendar cal = Calendar.getInstance();
		// I want to set the active since to 07 June 2012 , so the billing
		// process sees it and invoices it
		// set the calendar to 06/07
		cal.set(2010, 5, 7);
		OrderWS order = CreateObjectUtil.createOrderObject(user.getUserId(), 1,
				ServerConstants.ORDER_BILLING_POST_PAID, 1, cal.getTime());

		CreateObjectUtil.addLine(order, 10, ServerConstants.ORDER_LINE_TYPE_ITEM,
				itemId1, new BigDecimal(1.5), "Long Distance Call-intra state");

		order.setDueDateUnitId(PeriodUnitDTO.DAY);
		order.setDueDateValue(0);// order due

		order.setId(api.createOrder(order)); // create order
		order = api.getOrder(order.getId());
		assertNotNull("order created", order.getId());

		Integer[] invoiceIds = null;
		try {
			invoiceIds = api.createInvoiceWithDate(user.getUserId(),
					new Date(), PeriodUnitDTO.DAY, 45, false); // getAllInvoicesForUser(user.getUserId());
		} catch (Exception e) {
			if (e instanceof SessionInternalError
					&& e.getMessage().contains("Invalid Validation Key")) {
				// do nothing
			} else {
				assertTrue("Wrong exception raised", false);
			}
		}
		assertNull("No invoices must be generated", invoiceIds);

	}

	@Override
	protected Hashtable<String, String> getOptionalParametersForSuretaxPlugin() {
		// Pass a wrong client_number as the option parameter
		Hashtable<String, String> optionalParameters = new Hashtable<String, String>();
		optionalParameters.put(SureTaxCompositionTask.CLIENT_NUMBER, "000000");
		return optionalParameters;
	}

	@Override
	protected Hashtable<String, String> getOptionalParametersForSuretaxDeletePlugin() {
		// TODO Auto-generated method stub
		return null;
	}
}
