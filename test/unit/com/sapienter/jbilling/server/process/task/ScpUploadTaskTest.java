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

package com.sapienter.jbilling.server.process.task;

import com.sapienter.jbilling.common.Util;
import junit.framework.TestCase;

import java.io.File;
import java.util.Collections;
import java.util.List;

/**
 * @author Brian Cowdery
 * @since 08-06-2010
 */
public class ScpUploadTaskTest extends TestCase {

    private static final String BASE_DIR = Util.getBaseDir();

    private ScpUploadTask task = new ScpUploadTask(); // task under test

    public void testCollectFilesNonRecursive() throws Exception {
        File path = new File(BASE_DIR + File.separator + "logos");

        // entityNotification.properties should be the only file
        // located on the root jbilling/resources/ path.
        List<File> files = task.collectFiles(path, ".*\\.jpg", false);

        assertEquals(1, files.size());
        assertEquals("entity-1.jpg", files.get(0).getName());
    }

    public void testCollectFilesRecursive() throws Exception {
        File path = new File(BASE_DIR);

        // all jasper report designs are in a sub directory of the root
        // jbilling/resources/ path, and won't be found unless we scan recursively.
        List<File> nonRecursive = task.collectFiles(path, ".*designs.*\\.jasper", false);
        assertEquals(0, nonRecursive.size());

        // jasper report designs from jbilling/resources/designs/
        // found because we're scanning recursively.
        List<File> files = task.collectFiles(path, ".*designs.*\\.jasper", true);
        Collections.sort(files);

        assertEquals(8, files.size());
        assertEquals("invoice_design.jasper", files.get(0).getName());
        assertEquals("invoice_design_page2.jasper", files.get(1).getName());
        assertEquals("invoice_design_sub.jasper", files.get(2).getName());
        assertEquals("payment_notification_attachment.jasper", files.get(3).getName());
        assertEquals("simple_invoice.jasper", files.get(4).getName());
        assertEquals("simple_invoice_b2b.jasper", files.get(5).getName());
    }

    public void testCollectFilesCompoundRegex() throws Exception {
        File path = new File(BASE_DIR);

        // look for multiple files recursively matching *.jasper and *.jpg
        // should find files in jbilling/resources/design/ and jbilling/resources/logos/
        List<File> files = task.collectFiles(path, "(.*designs.*\\.jasper|.*\\.jpg)", true);
        Collections.sort(files);

        assertEquals(9, files.size());
        assertEquals("invoice_design.jasper", files.get(0).getName());
        assertEquals("invoice_design_page2.jasper", files.get(1).getName());
        assertEquals("invoice_design_sub.jasper", files.get(2).getName());
        assertEquals("payment_notification_attachment.jasper", files.get(3).getName());
        assertEquals("simple_invoice.jasper", files.get(4).getName());
        assertEquals("simple_invoice_b2b.jasper", files.get(5).getName());
        assertEquals("telco_invoice_vikas.jasper", files.get(6).getName());
        assertEquals("telco_invoice_vikas_events.jasper", files.get(7).getName());
        assertEquals("entity-1.jpg", files.get(8).getName());
    }

/*
    public void testScpUpload() throws Exception {
        File path = new File(baseDir);
        List<File> files = task.collectFiles(path, ".*entity-1\\.jpg$", true);

        assertEquals(1, files.size());

        // todo: fill in when testing
        String host = "";
        String username = "";
        String password = "";

        task.upload(files, null, host, username, password);        
    }
*/
}
