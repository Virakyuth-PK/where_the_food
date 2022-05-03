const productionBaseUrl = 'https://integrationapi.chipmongretail.com:8110/api';
const developmentBaseUrl = 'http://172.17.1.107/cmrtintegrationapi/api';

const version = 1;

var apiTimeOut = 50000;

var appStoreURL = "https://portal.chipmong.com/appstore";

const loginPath = '/v$version/Account/Login';
const checkCardByBarCodePath = '/v$version/MembershipCard/GetByCardId/';
const membershipCardUsageCreatePath =
    '/v$version/MembershipCardUsage/CreateAsync/';
const getAllLocationPath = '/v$version/Location/GetAllLocationAsync';
const getAllCardUsagepath = '/v$version/MembershipCard/GetAllCardUsage/';
const mobilePublishCheckUpdatePath = '/v$version/MobilePublish/CheckUpdate';

