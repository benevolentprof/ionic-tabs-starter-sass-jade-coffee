####
# Exception Handler
# Adapted from https://github.com/johnpapa/ng-demos/tree/master/modular/src/client/app/blocks/exception
####

'use strict'

exception = (logger) ->
  service =
    catcher : catcher
  # /////////////

  catcher = (message) ->
    (reason) ->
      logger.error message, reason
      return
  
  service

exception.$inject = ['logger']

angular
  .module('blocks.exception')
  .factory('exception', exception)