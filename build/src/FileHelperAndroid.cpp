#define MT_VEC2 1
#define MT_VEC3 2
#define MT_VEC4 3
#define MT_Q	4
#define MT_COLOR	5

#define LUA_LIB

#include "lua.h"
#include "lauxlib.h"

#include <stdio.h>
#include <string.h>

#include <jni.h>
#include <android/asset_manager.h>
#include <android/asset_manager_jni.h>
#include <sys/types.h>

#include <android/log.h>

#define  LOG_TAG    "main"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)

static AAssetManager * gAssetMgr = NULL;

#ifdef __cplusplus
extern "C" {
#endif
	void Java_org_c2man_main_MainActivity_nativeInit(JNIEnv* env, jclass cls, jobject assetManager)
	{
	    gAssetMgr = AAssetManager_fromJava(env, assetManager);
	}

	LUA_API void getAsset(const char* pszFileName, unsigned char*& pData, int& pSize)
	{
		do{
	        AAsset * pAsset = AAssetManager_open(gAssetMgr, pszFileName, AASSET_MODE_UNKNOWN);
	        if( pAsset == NULL ) break;
	        size_t size = AAsset_getLength(pAsset);
	        if( size > 0 )
	        {
	            pData = new unsigned char[size];
	            int iRet = AAsset_read( pAsset, pData, size);
	            if( iRet <= 0 )
	            {
	                delete [] pData;
	                pData = NULL;
	            }
	        }
	        AAsset_close(pAsset);
	        if( pAsset == NULL ) size = 0;
	        pSize = size;
	    } while(0);
	}

	LUA_API void freeObj(unsigned char* pData)
	{
	    delete [] pData;
	    pData = NULL;
	}

#ifdef __cplusplus
};
#endif


