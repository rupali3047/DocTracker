/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

/**
 *
 * @author ab-admin
 */
public class TransitDoc {
private int docid;
private String forwardedby;
private String forwardingOffice;

    public TransitDoc(int docid, String forwardedby, String forwardingOffice) {
        this.docid = docid;
        this.forwardedby = forwardedby;
        this.forwardingOffice = forwardingOffice;
    }

    public int getDocid() {
        return docid;
    }

    public void setDocid(int docid) {
        this.docid = docid;
    }

    public String getForwardedby() {
        return forwardedby;
    }

    public void setForwardedby(String forwardedby) {
        this.forwardedby = forwardedby;
    }

    public String getForwardingOffice() {
        return forwardingOffice;
    }

    public void setForwardingOffice(String forwardingOffice) {
        this.forwardingOffice = forwardingOffice;
    }

}
