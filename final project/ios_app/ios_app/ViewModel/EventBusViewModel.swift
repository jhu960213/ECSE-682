//
//  EventBusViewModel.swift
//  ios_app
//
//  Created by Jack Hu on 2020-11-29.
//

import Foundation

// contains APIs for the event bus
func callEvent(_ exposure_result:Bool) {
    // post event to update UI
    EventBus.post("UpdateUI", sender: ExposureEvent(exposure_result))
}

