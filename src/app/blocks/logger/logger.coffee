####
# Logging
# Code adapted from https://github.com/johnpapa/ng-demos/tree/master/modular/src/client/app/blocks/logger
####

'use strict'

logger = ($log) ->
  service =
    error   : error,
    info    : info,
    success : success,
    warning : warning,
    log     : $log.log

  #///////////////////////////

  error = (message, data) ->
    $log.error 'Error: ' + message, data
    return
  
  info = (message, data) ->
    $log.info 'Info: ' + message, data
    return
  
  success = (message, data) ->
    $log.info('Success: ' + message, data)
    return
  
  warning = (message, data) ->
    $log.warn('Warning: ' + message, data)

  service

logger.$inject = ['$log']

angular
    .module('blocks.logger')
    .factory('logger', logger)