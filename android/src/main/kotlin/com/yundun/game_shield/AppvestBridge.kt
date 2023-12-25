package com.yundun.game_shield

import com.cf.msc.sdk.AppVest
import com.cf.msc.sdk.SecurityConnection
import java.util.Objects

class AppvestBridge {
    // 生成一个单例
    companion object {
        val instance = AppvestBridge()
    }
    val appVest: AppVest? = null

    fun initSDK(accesskey: String, uuid: String): Int {
        val res = AppVest.init(accesskey, uuid)
        if (res == -1) {
            println("失败")
            return -1
        }
        return 0
    }

    fun getServerIPAndPort(host: String, port: Int): Map<String, Any>? {
        val conn = AppVest.getServerIPAndPort(host, port);
        if (conn.serverPort == -1) {
            return null;
        }
        return mapOf("ip" to conn.serverIp, "port" to conn.serverPort)
    }

    fun getClientIP(): String? {
        return AppVest.getClientIP()
    }

    fun getProxyServerIP(): String? {
        return AppVest.getProxyServerIP()
    }
}