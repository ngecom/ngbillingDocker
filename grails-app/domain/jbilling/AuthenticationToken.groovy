package jbilling

class AuthenticationToken {

	
	String tokenValue
	String username
	
	
    static mapping = {
        id generator: 'org.hibernate.id.enhanced.TableGenerator',
           params: [
           table_name: 'jbilling_seqs',
           segment_column_name: 'name',
           value_column_name: 'next_id',
           segment_value: 'authentication_token'
           ]
    }
}
