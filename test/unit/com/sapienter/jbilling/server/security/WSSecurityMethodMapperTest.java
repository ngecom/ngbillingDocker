/*
 jBilling - The Enterprise Open Source Billing System
 Copyright (C) 2003-2011 Enterprise jBilling Software Ltd. and Emiliano Conde

 This file is part of jbilling.

 jbilling is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 jbilling is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with jbilling.  If not, see <http://www.gnu.org/licenses/>.

 This source was modified by Web Data Technologies LLP (www.webdatatechnologies.in) since 15 Nov 2015.
You may download the latest source from webdataconsulting.github.io.

 */

package com.sapienter.jbilling.server.security;

import com.sapienter.jbilling.server.security.methods.SecuredMethodFactory;
import com.sapienter.jbilling.server.security.methods.SecuredMethodSignature;
import com.sapienter.jbilling.server.security.methods.SecuredMethodType;
import com.sapienter.jbilling.server.util.IWebServicesSessionBean;
import junit.framework.TestCase;

import java.lang.reflect.Method;

/**
 * WSSecurityMethodMapperTest
 *
 * @author Brian Cowdery
 * @since 19/05/11
 */
public class WSSecurityMethodMapperTest extends TestCase {

    @Override
    protected void setUp() throws Exception {
        super.setUp();
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    /**
     * Quick initialization test to make sure that the mapped web-services API methods
     * exist and can be initialized by the mapper.
     *
     * Useful for catching initialization errors when the API changes.
     *
     * @throws Exception
     */
    public void testWSSecureMethodEnum() throws Exception {
        // init mapper
        WSSecurityMethodMapper mapper = new WSSecurityMethodMapper();
        SecuredMethodSignature method = SecuredMethodFactory.getSignatureByMethodName("getUserWS");
        assertNotNull(method);
    }

    public void testWSSecureMethodType() throws Exception {
        // init mapper
        WSSecurityMethodMapper mapper = new WSSecurityMethodMapper();
        SecuredMethodSignature method = SecuredMethodFactory.getSignatureByMethodName("getUserWS");
        assertNotNull(method);
        assertEquals(method.getType(), SecuredMethodType.USER);
    }
}
