//
//  AppStateConvivaReporter.swift
//  

import ConvivaSDK
import AVFoundation

struct AppEventConvivaReporter: AppEventProcessor {
    let analytics: CISAnalytics
    let videoAnalytics: CISVideoAnalytics
    let adAnalytics: CISAdAnalytics
    let storage: ConvivaConnectorStorage

    func appWillEnterForeground(notification: Notification) {
        self.analytics.reportAppForegrounded()
    }
    
    func appDidEnterBackground(notification: Notification) {
        self.analytics.reportAppBackgrounded()
    }
    
    func appGotNewAccessLogEntry(event: AVPlayerItemAccessLogEvent, isPlayingAd: Bool) {
        let endpoint = isPlayingAd ? self.adAnalytics : self.videoAnalytics

        self.handleBitrateChange(bitrate: event.indicatedBitrate, endpoint: endpoint)
        
        if event.numberOfDroppedVideoFrames >= 0 {
            endpoint.reportPlaybackMetric(CIS_SSDK_PLAYBACK_METRIC_DROPPED_FRAMES_TOTAL, value: NSNumber(value: event.numberOfDroppedVideoFrames))
        }
    }

    func appGotBitrateChangeEvent(bitrate: Double, isPlayingAd: Bool) {
        let endpoint = isPlayingAd ? self.adAnalytics : self.videoAnalytics
        self.handleBitrateChange(bitrate: bitrate, endpoint: endpoint)
    }

    private func handleBitrateChange(bitrate: Double, endpoint: CISStreamAnalyticsProtocol) {
        guard bitrate >= 0 else { return }

        let bitrateValue = NSNumber(value: bitrate / 1000)

        endpoint.reportPlaybackMetric(CIS_SSDK_PLAYBACK_METRIC_BITRATE, value: bitrateValue)
        self.storage.storeKeyValuePair(key: CIS_SSDK_PLAYBACK_METRIC_BITRATE, value: bitrateValue)
    }
}
