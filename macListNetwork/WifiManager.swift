//
//  WifiManager.swift
//  macListNetwork
//
//  Created by Angelos Staboulis on 24/6/25.
//

import Foundation

class WifiManager{
    func err(_ message: String) {
        FileHandle.standardError.write((message + "\n").data(using: .utf8)!)
    }
    
    func getConnectedWifi() -> String {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.arguments = ["-c", "system_profiler SPAirPortDataType | awk '/Current Network/ {getline;$1=$1;print $0 | \"tr -d \':\'\";exit}'"]
      

        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        do {
            try task.run()
        } catch {
            return "Error executing process"
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)

      
        
        return output ?? "No Wi-Fi network detected."
    
    }
    func getListWifi() -> String {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.arguments = ["-c", "system_profiler SPAirPortDataType | awk '/Other Local Wi-Fi Networks:/,/awdl0:/' | awk '!/Other Local Wi-Fi Networks:/ && !/awdl0:/' | grep ':$' | sed 's/:$//' | sed 's/^[ \t]*//'"]
      

        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        do {
            try task.run()
        } catch {
            return "Error executing process"
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
      
        
        return output ?? "No Wi-Fi network detected."
    
    }
}
