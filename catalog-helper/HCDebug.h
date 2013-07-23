//
//  HCDebug.h
//  catalog-helper
//
//  Created by Andreas Pohle on 18.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#ifndef catalog_helper_HCDebug_h
#define catalog_helper_HCDebug_h

#ifdef DEBUG
#   define HC_DBG_LOG_FUNC_ENTER NSLog((@">>> %s"), __PRETTY_FUNCTION__)
#   define HC_DBG_LOG_FUNC_EXIT  NSLog((@"<<< %s"), __PRETTY_FUNCTION__)
#   define HC_DBG_LOG_FUNC_CALL  NSLog((@"=== %s"), __PRETTY_FUNCTION__)
#   define HC_DLog(fmt, ...) NSLog((@"    %s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#   define HC_DBG_LOG_FUNC_ENTER
#   define HC_DBG_LOG_FUNC_EXIT
#   define HC_DBG_LOG_FUNC_CALL
#   define HC_DLog(...)
#endif

#endif
