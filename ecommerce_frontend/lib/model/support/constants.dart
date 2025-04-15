class Constants{

  static final String ADDRESS_STORE_SERVER = "localhost:9090";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  static final String REALM = "ecommerce-realm";
  static final String CLIENT_ID = "ecommerce-client";
  static final String CLIENT_SECRET = "CE1e41DXoE0mrhEwkdDqLX14a4J9DgC1";

  static final String REQUEST_LOGIN = "/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "/realms/" + REALM + "/protocol/openid-connect/logout";

  static final String REQUEST_ALL_SHIRTS = "/shirts/getReadyToSell";
  static final String REQUEST_PAYMENT= "/payments/pay";
  static final String REQUEST_ADD_USER= "/auth/register";
  static final String ADD_ORDER= "/cart/addOrdine";
  static final String REQUEST_GET_USER= "/auth/getUser";

  static final wmax = 320.0;
  static final hmax = 450.0;
  static final wfmax = 250.0;
  static const pmd = 8.0;

}