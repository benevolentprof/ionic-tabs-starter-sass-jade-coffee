####
# Exception Handler Provider
# Adapted from https://github.com/johnpapa/ng-demos/tree/master/modular/src/client/app/blocks/exception
####

'use strict'

###*
# Must configure the exception handling
# @return {[type]}
###

exceptionHandlerProvider = ->
  @config = appErrorPrefix : undefined
  
  @configure = (appErrorPrefix) ->
    @config.appErrorPrefix = appErrorPrefix

  @$get = ->
    {config : config}
    return

###*
# Configure by setting an optional string value for appErrorPrefix.
# Accessible via config.appErrorPrefix (via config value).
# @param  {[type]} $provide
# @return {[type]}
###

config = ($provide) ->
  $provide.decorator '$exceptionHandler', extendExceptionHandler

config.$inject = ['$provide']

###*
# Extend the $exceptionHandler service to log the issue
# @param  {Object} $delegate
# @param  {Object} exceptionHandler
# @param  {Object} logger
# @return {Function} the decorated $exceptionHandler service
###

extendExceptionHandler = ($delegate, exceptionHandler, logger) ->
  (exception, cause) ->
    appErrorPrefix = exceptionHandler.config.appErrorPrefix or ''
    errorData = {
      exception: exception
      cause:     cause
    }
    exceptionmessage = appErrorPrefix + exception.message
    $delegate exception, cause
    
    ###*
    # Could add the error to a service's collection,
    # add errors to $rootScope, log errors to remote web server,
    # or log locally. Or throw hard. It is entirely up to you.
    # throw exception;
    #
    # @example
    #     throw { message: 'error message we added' };
    ###

    logger.error exception.message, errorData
    return

extendExceptionHandler.$inject = ['$delegate', 'exceptionHandler', 'logger']

angular
  .module('blocks.exception')
  .provider('exceptionHandler', exceptionHandlerProvider)
  .config(config)