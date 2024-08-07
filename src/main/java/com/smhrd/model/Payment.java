package com.smhrd.model;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Payment {

	private Amount amount;
	private String status;
	private Method method;
	
	
	

    public Method getMethod() {
		return method;
	}

	public void setMethod(Method method) {
		this.method = method;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Amount getAmount() {
        return amount;
    }

    public void setAmount(Amount amount) {
        this.amount = amount;
    }

    
    
    
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Amount {
        private int total;

        public int getTotal() {
            return total;
        }

        public void setTotal(int total) {
            this.total = total;
        }
        
    }
    
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Method {
    	private String type;  // 결제수단 유형
    	private String accountNumber; //(무통장입금일 떄) 계좌 번호
    	 private String bank; // 어디 은행인지
    	
    	public String getBank() {
			return bank;
		}
		public void setBank(String bank) {
			this.bank = bank;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getAccountNumber() {
			return accountNumber;
		}
		public void setAccountNumber(String accountNumber) {
			this.accountNumber = accountNumber;
		}
		
    	
    	
    }
	
	
}
