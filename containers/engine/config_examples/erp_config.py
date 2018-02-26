"""Global configuration variables go here. Variables that differ by environment are imported."""

from datetime import timedelta

import logging
import datetime as _datetime

# CORE CREDENTIALS
AWSKEY = ""
AWSSECRET = ""
SSH_KEY = ""

SERVERTZ = 'UTC'

# EMAILS
DEV_EMAIL = ""
ERROR_EMAIL = NOTIFICATION_INFO_EMAIL = NOTIFICATION_VENDORS = NOTIFICATION_ORDERS = NOTIFICATION_ACCOUNTS = \
    NOTIFICATION_QUOTES = NOTIFICATION_SUPPORT_EMAIL = NOTIFICATION_OUTSOURCE = NOTIFICATION_WEPAY = DEV_EMAIL
MESSAGE_DOMAIN = 'testorders.xxxxxxxxxx.com'

# FLAGS
DEBUG = True
USE_HUBSPOT = True
USE_ENGINE = True
USE_CDN = True

# BUCKETS
S3_WEB_CACHE_BUCKET = "qa-parts"
S3_PARTS_BUCKET = "qa-parts"
S3_OPS_BUCKET = "qa-parts"
S3_DATA_BUCKET = "qa-parts"
S3_USER_DATA_BUCKET = "qa-parts"

# CDN
#QA Cloudfront
QUOTE_CDN_DOMAIN = "d3jiy2nldgkzi3.cloudfront.net"
ERP_CDN_DOMAIN = "d15pz43sag3hbd.cloudfront.net"
CACHE_TYPE = "simple" #memcached"

# FLASK DEV STUFF
WEB_SERVER_NAME = "xxxxxxxxxx.net"
API_SERVER_NAME = "qa-api.xxxxxxxxxx.net"
SESSION_COOKIE_DOMAIN = "xxxxxxxxxx.net"

ERP_SUB = "qa-erp"
VP_SUB = "qa-work"
QUOTE_SUB = "qa-get"

# TODO: This should go...
WEBAPP_ROOT = "https://qa-get.xxxxxxxxxx.net"
API_ROOT = "https://qa-api.xxxxxxxxxx.net/v1/"
SOCKET_ROOT = "https://qa-api.xxxxxxxxxx.net"
ERP_ROOT = "https://qa-erp.xxxxxxxxxx.net"
VP_ROOT = "https://qa-work.xxxxxxxxxx.net"
HOME_PAGE_ROOT = "http://qa-www.xxxxxxxxxx.net"

X_DOMAINS = [API_ROOT, WEBAPP_ROOT, ERP_ROOT, VP_ROOT]

# MONGO
MONGO_USER = "xxxxxxxxxx_api"
MONGO_PWD = "theraflu"
MONGO_HOST = "10.7.6.65"
MONGO_DBNAME = "xxxxxxxxxx"
MONGO_PORT = 27017

# REDIS
REDISKEYBASE = 'stage'

# LOGSTASH
LOGLEVEL = logging.INFO
LOG_FILE = False
LOGSTASH_HOST = "localhost"
LOGSTASH_PORT = 5959

CRON_LOGGER_PORT = 9999
EMAIL_LOGGER_PORT = 9998
API_LOGGER_PORT = 9997
ERP_LOGGER_PORT = 9996
GET_LOGGER_PORT = 9995
HUBSPOT_LOGGER_PORT = 9994

# AUTHORIZE.NET CREDENTIALS
AUTHORIZE_LOGIN_ID = ""
AUTHORIZE_TRANSACTION_KEY = ""

# UPS
UPS_LICENSE_NUMBER = ""
UPS_USER_ID = ""
UPS_PASSWORD = ""
UPS_ACCOUNT_NUMBER = ""

# LEGACY_TOS_CUTOFF is used as the default time before any new
# revisions have been added.
LEGACY_TOS_CUTOFF = _datetime.datetime(2014, 1, 1)

# TOS CONFIGS:
# Most recent dates for Policies
VENDOR_TOS = _datetime.datetime(2014, 1, 1)
CUSTOMER_TOS = _datetime.datetime(2015, 9, 15)
GENERAL_TOS = _datetime.datetime(2014, 1, 1)
PRIVACY_POLICY = _datetime.datetime(2016, 3, 28)

# WEPAY CREDENTIALS - STAGING
TRANSACTION_PORTAL = "WEPAY" #options: 'WEPAY','AUTHORIZE'

WEPAY_CLIENT_ID = ""
WEPAY_CLIENT_SECRET = ""
WEPAY_ACCESS_TOKEN = ""
WEPAY_ACCOUNT_ID = ""
WEPAY_API_ENDPOINT_TEST = "https://stage.wepayapi.com/v2"
WEPAY_API_ENDPOINT_PRODUCTION = "https://wepayapi.com/v2"
MAX_ATTEMPTS_WEPAY = 5

ENGINEAMI = ''

#SHIPPO
SHIPPO_KEY = ""
SHIPPO_WEBHOOK = ""



# EVE

API_VERSION = 'v1'
DOMAIN = {}
SCHEMA_ENDPOINT = 'schema'
BANDWIDTH_SAVER = False
SOFT_DELETE = True
UPSERT_ON_PUT = False
TRANSPARENT_SCHEMA_RULES = True
X_EXPOSE_HEADERS = ['Access-Control-Allow-Origin']
X_HEADERS = ['Content-Type', 'X-CSRFToken', 'Cache-Control',
             'X-Requested-With', 'Authorization', 'If-Match']
X_ALLOW_CREDENTIALS = True
DATE_CREATED = '_constructed'
LAST_UPDATED = '_updated'
DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ'
PAGINATION_LIMIT = 1000

# EMBEDDING = True

# PORTS (these rarely change and are the same for all environments)
REDISPORT = 6379
# WEBDISPORT = 443
WEBDISPORT = 7379
ERP_FLASK_PORT = 5002

#
INACTIVITY_DURATION_BEFORE_LOGOUT = timedelta(days=72)

# HOSTS AND CREDENTIALS THAT ARE THE SAME EVERYWHERE

# REDIS
REDISHOST = "messages.xxxxxxxxxx.com"

# ZIP-TAX
ZIPTAX_API_KEY = "JXPCBYK"

# HUBSPOT
HS_API_URL = "http://api.hubapi.com"

if DEBUG:
    HS_API_KEY = ""
    HS_USER_WF = ""
    HS_ORDER_WF = ""
    HS_SHIPPING_WF = ""
    HS_ABANDONED_WF = ""
else:
    HS_API_KEY = ""
    HS_USER_WF = ""
    HS_ORDER_WF = ""
    HS_SHIPPING_WF = ""
    HS_ABANDONED_WF = ""
HS_AQUOTE_WF = ""
HS_SQUOTE_WF = ""
HS_FORMS_API_URL = "https://forms.hubspot.com/uploads/form/v2/"

# WEPAY
if DEBUG:
    WEPAY_API_URL = WEPAY_API_ENDPOINT_TEST
else:
    WEPAY_API_URL = WEPAY_API_ENDPOINT_PRODUCTION

# PIVOTAL TRACKER
PT_API_KEY = ""
PT_PROJECT_ID = ""
PT_API_ROOT = "https://www.pivotaltracker.com/services/v5/projects/" + PT_PROJECT_ID

# GITHUB MACHINE USER
GH_ACCESS_TOKEN = ""
GH_USERNAME = "webmaster@xxxxxxxxxx.com"
