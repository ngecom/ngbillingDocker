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

import org.apache.log4j.DailyRollingFileAppender
import org.springframework.web.context.request.RequestContextHolder
import org.springframework.web.context.request.RequestAttributes

/*
    Load configuration files from the set "NGBILLING_HOME" path (provided as either
    an environment variable or a command line system property). External configuration
    files will override default settings.
 */

def appHome = System.getProperty("NGBILLING_HOME") ?: System.getenv("NGBILLING_HOME")

if (appHome) {
    println "Loading configuration files from NGBILLING_HOME = ${appHome}"
    grails.config.locations = [
            "file:${appHome}/${appName}-Config.groovy",
            "file:${appHome}/${appName}-DataSource.groovy"
    ]

} else {
    appHome = new File("../${appName}")
    if (appHome.listFiles({dir, file -> file ==~ /${appName}-.*\.groovy/} as FilenameFilter )) {
        println "Loading configuration files from ${appHome.canonicalPath}"
        grails.config.locations = [
                "file:${appHome.canonicalPath}/${appName}-Config.groovy",
                "file:${appHome.canonicalPath}/${appName}-DataSource.groovy"
        ]

        println "Setting NGBILLING_HOME to ${appHome.canonicalPath}"
        System.setProperty("NGBILLING_HOME", appHome.canonicalPath)

    } else {
        println "Loading configuration files from classpath"
    }
}
grails.databinding.useSpringBinder = true
grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']


grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'raw' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        filteringCodecForContentType.'text/html' = 'html'
    }
}

grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// use the jQuery javascript library
grails.views.javascript.library="jquery"
// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = ['com.sapienter.jbilling.server.config']
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password', 'creditCard', 'creditCardDTO']

// enable query caching by default
grails.hibernate.cache.queries = false

// set per-environment serverURL stem for creating absolute links
environments {
//    production {
//        grails.serverURL = "http://www.changeme.com"
//    }
    // see issue http://jira.grails.org/browse/GRAILS-7598
}


/*
    Logging
 */
// log4j configuration
log4j = {
    appenders {
        console name: 'stdout',Threshold: "INFO", Target: "System.out",  layout:pattern(conversionPattern: '%d %-5r %-5p [%c] (%t:%x) %m%n')
        appender new DailyRollingFileAppender(name: 'jbilling', file: 'logs/jbilling.log', datePattern: '\'_\'yyyy-MM-dd', layout:pattern(conversionPattern: '%d %-5r %-5p [%c] (%t:%x) %m%n'))
        appender new DailyRollingFileAppender(name: 'sql', file: 'logs/sql.log', datePattern: '\'_\'yyyy-MM-dd', layout:pattern(conversionPattern: '%d %-5r %-5p [%c] (%t:%x) %m%n'))
        appender new DailyRollingFileAppender(name: 'diameter', file: 'logs/diameter.log', datePattern: '\'_\'yyyy-MM-dd', layout:pattern(conversionPattern: '%d %-5r %-5p [%c] (%t:%x) %m%n'))
		rollingFile name: "stacktrace", maxFileSize: '5MB', maxBackupIndex:2, file: "logs/jbilling-stacktrace.log"
    }

    environments {
        production {
            root {
                info 'jbilling'
                additivity: false
            }
        }
        development {
            root {
                info 'stdout', 'jbilling'
                additivity: false
            }
        }
    }

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.hibernate',
           'org.springframework',
           'net.sf.ehcache.hibernate',
           'org.apache.zookeeper',
           'org.apache.hadoop.hbase'

    warn   'org.apache.catalina'

    info   'com.mchange'

	//***** INFO ON CHANGING LOGGING LEVELS *****
	//To change the logging level. Keep the higher packages at most detailed level (debug) and reduce logging on lower packages
	//Example below: grails.app is on debug level. grails.app.taglib is on info level. So everything except grails.app.taglib will be in debug
	//Specifying "jbilling" as the appender here so that all logs go to jbilling.log
	//***** END INFO *****

    debug additivity: false, jbilling: "in.webdata"
    debug additivity: false, jbilling: "in.webdataconsulting"
    debug additivity: false, jbilling: "com.sapienter.jbilling"
    debug additivity: false, jbilling: "grails.app"
    debug additivity: false, jbilling: "grails.app.service"
    debug additivity: false, jbilling: "grails.app.controller"

    //Keep this in info to reduce the verbocity of logs
    info additivity: false, jbilling: "grails.app.taglib"

    info additivity: false,  jbilling: "com.sapienter.jbilling.client.authentication.CompanyUserRememberMeFilter"

//      Hibernate logging:
//      org.hibernate.SQL           Log all SQL DML statements as they are executed
//      org.hibernate.type          Log all JDBC parameters
//      org.hibernate.tool.hbm2ddl  Log all SQL DDL statements as they are executed
//      org.hibernate.pretty        Log the state of all entities (max 20 entities) associated with the session at flush time
//      org.hibernate.cache         Log all second-level cache activity
//      org.hibernate.transaction   Log transaction related activity
//      org.hibernate.jdbc          Log all JDBC resource acquisition
//      org.hibernate.hql.ast.AST   Log HQL and SQL ASTs during query parsing
//      org.hibernate.secure        Log all JAAS authorization requests
//      org.hibernate               Log everything. This is a lot of information but it is useful for troubleshooting


    // debug additivity: false, sql: "org.hibernate.SQL"
     debug additivity: false, diameter: "org.jdiameter"

}

/*
    Static web resources
 */
grails.resources.modules = {
    'core' {
        defaultBundle 'core-ui'

        resource url: '/css/all.css', attrs: [ media: 'screen' ]
        resource url: '/css/lt7.css', attrs: [ media: 'screen' ],
                 wrapper: { s -> "<!--[if lt IE 8]>$s<![endif]-->" }
    }

    'ui' {
        dependsOn 'jquery'
        defaultBundle 'core-ui'

        resource url: '/js/main.js', disposition: 'head'
        resource url: '/js/datatable.js', disposition: 'head'
        resource url: '/js/slideBlock.js', disposition: 'head'
    }

    'input' {
		dependsOn 'jquery'
        defaultBundle "input"

        resource url: '/js/form.js', disposition: 'head'
        resource url: '/js/checkbox.js', disposition: 'head'
        resource url: '/js/clearinput.js', disposition: 'head'
    }

    'disjointlistbox' {
        defaultBundle "disjointlistbox"

        resource url: '/js/disjointlistbox.js', disposition: 'head'
    }

    'panels' {
		dependsOn 'jquery'
        defaultBundle 'panels'

        resource url: '/js/panels.js', disposition: 'head'
    }

    'jquery-validate' {
		dependsOn 'jquery'
        defaultBundle "jquery-validate"

        resource url: '/js/jquery-validate/jquery.validate.min.js', disposition: 'head'
        resource url: '/js/jquery-validate/additional-methods.min.js', disposition: 'head'
        resource url: '/js/jquery-migrate-1.2.1.js'
    }

    'errors' {
        defaultBundle "errors"

        resource url: '/js/errors.js', disposition: 'head'
    }

    'showtab' {
        defaultBundle: "showtab"
        resource url: '/js/showtab.js', disposition: 'head'
    }
    overrides {
		'jquery-theme' {
			resource id:'theme', url:'/jquery-ui/themes/jbilling/jquery-ui-1.10.4.custom.css'
		}
    }

    itg {
//        dependsOn("jquery", "jquery-ui")

        resource(url: 'css/ict.css')
        resource(url: 'css/alpaca.min.css')
        resource(url: 'css/alpaca-jqueryui.min.css')
        resource(url: 'css/evol.colorpicker.css')
        resource(url: 'css/jstree/invoice-template-tree.css')

//        resource(url: 'js/jquery.jstree.js')
//        resource(url: 'js/alpaca.min.js')
//        resource(url: 'js/evol.colorpicker.min.js')
//        resource(url: 'js/json/invoiceTemplate-schema.js')
    }
}


/*
    Documentation
 */
grails.doc.authors="Emiliano Conde, Brian Cowdery, Emir Calabuch, Lucas Pickstone, Vikas Bodani, Crystal Bourque"
grails.doc.license="AGPL v3"
grails.doc.images=new File("src/docs/images")
grails.doc.api.org.springframework="http://static.springsource.org/spring/docs/3.0.x/javadoc-api/"
grails.doc.api.org.hibernate="http://docs.jboss.org/hibernate/stable/core/javadocs/"
grails.doc.api.java="http://docs.oracle.com/javase/6/docs/api/"

//gdoc aliases
grails.doc.alias.userGuide="1. jBilling User Guide"
grails.doc.alias.integrationGuide="2. jBilling Integration Guide"



/*
    Spring Security
 */
// require authentication on all URL's
grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false

// failure url
grails.plugin.springsecurity.failureHandler.defaultFailureUrl = '/login/authfail?login_error=1'
grails.plugin.springsecurity.failureHandler.ajaxAuthFailUrl = '/login/authfail?login_error=1'

//success handler
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true

// remember me cookies
grails.plugin.springsecurity.rememberMe.cookieName = "jbilling_remember_me"
grails.plugin.springsecurity.rememberMe.key = "xANgU6Y7lJVhI"

// allow user switching
grails.plugin.springsecurity.useSwitchUserFilter = true
grails.plugin.springsecurity.switchUser.targetUrl = '/user/reload'
grails.plugin.springsecurity.switchUser.switchFailureUrl = '/user/failToSwitch'

/*
    Spring Batch
*/
//Task Executor Settings
springbatch.executor.core.pool.size=6
springbatch.executor.max.pool.size=10

//Billing Process Grid Size
springbatch.billing.process.grid.size=6

//Ageing Process Grid Size
springbatch.ageing.process.grid.size=6

// static security rules 
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
        '/j_spring_security_switch_user': []
]

// configure which URL's require HTTP and which require HTTPS
/*
portMapper.httpPort = 8080
portMapper.httpsPort = 8443

grails.plugins.springsecurity.secureChannel.definition = [
    '/version': 'REQUIRES_INSECURE_CHANNEL',
    '/css/**': 'ANY_CHANNEL',
    '/images/**': 'ANY_CHANNEL'
]
*/

// basic HTTP authentication filter for web-services
grails.plugin.springsecurity.useBasicAuth = true
grails.plugin.springsecurity.basic.realmName = "jBilling Web Services"

// authentication filter configuration
grails.plugin.springsecurity.filterChain.chainMap = [
        '/**': 'JOINED_FILTERS,-basicAuthenticationFilter,-basicExceptionTranslationFilter, -statelessSecurityContextPersistenceFilter'
]

// voter configuration
grails.plugin.springsecurity.voterNames = ['authenticatedVoter', 'roleVoter', 'webExpressionVoter']
// Valid Company Invoice Logo Image Type
validImageExtensions = ['image/png', 'image/jpeg', 'image/gif']

grails.plugin.springsecurity.useSecurityEventListener = true

//events published by the provider manager
grails.plugin.springsecurity.onInteractiveAuthenticationSuccessEvent = { e, appCtx ->
}

grails.plugin.springsecurity.onAuthenticationSuccessEvent = { e, appCtx ->
    def request= RequestContextHolder?.currentRequestAttributes()
    if (request?.params?.get('interactive_login') ) {
        appCtx.getBean("appAuthResultHandler").loginSuccess(e)
    }
}


grails.plugin.springsecurity.onInteractiveAuthenticationSuccessEvent = { e, appCtx ->
    appCtx.getBean("tabConfigurationService").load()
}

grails.plugin.springsecurity.onAbstractAuthenticationFailureEvent = { e, appCtx ->
    appCtx.getBean("appAuthResultHandler").loginFailure(e)
	def request= RequestContextHolder?.currentRequestAttributes()
	def client_id = request?.params?.get('j_client_id')
	request.setAttribute("login_company", client_id, RequestAttributes.SCOPE_SESSION);
	RequestContextHolder.setRequestAttributes(request);
}

// Valid Company Invoice Logo Image Type
validImageExtensions = ['image/png', 'image/jpeg', 'image/gif']

// Disable the new ChainedTransactionManager (from Grails 2.3.7)
// for now. It is known to conflict with the BE1PC config for JMS
grails.transaction.chainedTransactionManagerPostProcessor.blacklistPattern = '.*'






//cors config.
cors.enabled=true
cors.url.pattern = '/api/*'
cors.headers=[
	'Access-Control-Allow-Origin': '*',
	'Access-Control-Allow-Credentials': true,
	'Access-Control-Allow-Headers': 'origin, authorization, accept, content-type, x-requested-with',
	'Access-Control-Allow-Methods': 'GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS',
	'Access-Control-Max-Age': 3600
	]


//Config for Spring Security REST plugin

//login
grails.plugin.springsecurity.rest.login.active=true
grails.plugin.springsecurity.rest.login.endpointUrl="/api/login"
grails.plugin.springsecurity.rest.login.failureStatusCode=401
grails.plugin.springsecurity.rest.login.useJsonCredentials=true
grails.plugin.springsecurity.rest.login.usernamePropertyName='username'
grails.plugin.springsecurity.rest.login.passwordPropertyName='password'

//logout
grails.plugin.springsecurity.rest.logout.endpointUrl='/api/logout'
grails.plugin.springsecurity.rest.token.validation.headerName='X-Auth-Token'

//token generation
grails.plugin.springsecurity.rest.token.generation.useSecureRandom=true
grails.plugin.springsecurity.rest.token.generation.useUUID=false

//token storage
// use memcached.
//grails.plugin.springsecurity.rest.token.storage.useMemcached  false
//grails.plugin.springsecurity.rest.token.storage.memcached.hosts   localhost:11211
//grails.plugin.springsecurity.rest.token.storage.memcached.username    ''
//grails.plugin.springsecurity.rest.token.storage.memcached.password    ''
//grails.plugin.springsecurity.rest.token.storage.memcached.expiration  3600

//use GROM
grails.plugin.springsecurity.rest.token.storage.useGorm   = true
grails.plugin.springsecurity.rest.token.storage.gorm.tokenDomainClassName = 'jbilling.AuthenticationToken'
grails.plugin.springsecurity.rest.token.storage.gorm.tokenValuePropertyName  = 'tokenValue'
grails.plugin.springsecurity.rest.token.storage.gorm.usernamePropertyName = 'username'

/*
//use cache as storage
grails.plugin.springsecurity.rest.token.storage.useGrailsCache=true
grails.plugin.springsecurity.rest.token.storage.grailsCacheName='xauth-token'
*/

//token rendering
grails.plugin.springsecurity.rest.token.rendering.usernamePropertyName='username'
grails.plugin.springsecurity.rest.token.rendering.authoritiesPropertyName='role'
grails.plugin.springsecurity.rest.token.rendering.tokenPropertyName='token'


//token validate
grails.plugin.springsecurity.rest.token.validation.useBearerToken = false
grails.plugin.springsecurity.rest.token.validation.active=true
grails.plugin.springsecurity.rest.token.validation.endpointUrl='/api/validate'
grails.plugin.springsecurity.rest.token.validation.headerName='X-Auth-Token'


grails.plugin.springsecurity.filterChain.chainMap = [
		
		'/api/**': 'JOINED_FILTERS,-anonymousAuthenticationFilter,-exceptionTranslationFilter,-authenticationProcessingFilter,-securityContextPersistenceFilter',
		'/**': 'JOINED_FILTERS,-basicAuthenticationFilter,-basicExceptionTranslationFilter, -statelessSecurityContextPersistenceFilter'
 ]


