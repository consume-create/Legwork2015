###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

Utils = {

  ###
  *------------------------------------------*
  | transform
  |
  | Get browser specific transform.
  *----------------------------------------###
  'transform':
    Modernizr.prefixed('transform').replace(/([A-Z])/g, (str,m1) => 
      return '-' + m1.toLowerCase()
    ).replace(/^ms-/,'-ms-')
  ,

  ###
  *------------------------------------------*
  | translate
  |
  | Get browser specific translate.
  *----------------------------------------###
  'translate': (x, y) =>
    tran = if Modernizr.csstransforms3d then 'translate3d' else 'translate'
    vals = if Modernizr.csstransforms3d then '(' + x + ', ' + y + ', 0)' else '(' + x + ', ' + y + ')'
    return tran + vals
  ,

  ###
  *------------------------------------------*
  | transition_end
  |
  | Get browser specific transition end.
  *----------------------------------------###
  'transition_end': 
    (=>
      transEndEventNames = {
        'WebkitTransition' : 'webkitTransitionEnd',
        'MozTransition'    : 'transitionend',
        'OTransition'      : 'oTransitionEnd otransitionend',
        'msTransition'     : 'MSTransitionEnd',
        'transition'       : 'transitionend'
      }

      return transEndEventNames[Modernizr.prefixed('transition')]
    )()
  ,

  ###
  *------------------------------------------*
  | is_mobile
  |
  | Get mobile.
  *----------------------------------------###
  'is_mobile':
    {
      'Android': ->
        return (/Android/i).test(navigator.userAgent)
      ,
      'BlackBerry': ->
        return (/BlackBerry/i).test(navigator.userAgent)
      ,
      'iOS': ->
        return (/iPhone|iPad|iPod/i).test(navigator.userAgent)
      ,
      'Opera': ->
        return (/Opera Mini/i).test(navigator.userAgent)
      ,
      'Windows': ->
        return (/IEMobile/i).test(navigator.userAgent)
      ,
      'any': ->
        return (
          (/Android/i).test(navigator.userAgent) or 
          (/BlackBerry/i).test(navigator.userAgent) or 
          (/iPhone|iPad|iPod/i).test(navigator.userAgent) or 
          (/Opera Mini/i).test(navigator.userAgent) or 
          (/IEMobile/i).test(navigator.userAgent)
        )
    }
}

module.exports = Utils