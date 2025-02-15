//
//  ContentView.swift
//  pomodoro
//
//  Created by USER on 2025/02/15.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 25 * 60
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var isWorkTime = true

    var body: some View {
        VStack {
            Text(isWorkTime ? "Let's Work👨‍💻" : "Break☕️")
                .font(.title)
                .padding()

            Text("\(timeString(time: timeRemaining))")
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .padding()

            HStack(spacing: 20) {
                Button(action: startTimer) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isRunning ? Color.orange : Color.blue)
                            .frame(width: 100, height: 40)
                        Text(isRunning ? "Stop🛑" : "Start🏃‍♂️")
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.borderless)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                Button(action: resetTimer) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .frame(width: 100, height: 40)
                        Text("Reset🔄")
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.borderless)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Button(action: switchTimerModeManually) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 200, height: 40)
                    Text(isWorkTime ? "Switch to Break☕️" : "Switch to Work👨‍💻")
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.borderless)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 10)
        }
        .padding()
        .frame(minWidth: 300, idealWidth: 350, maxWidth: 400, minHeight: 250, idealHeight: 300, maxHeight: 350)
    }

    func startTimer() {
        if isRunning {
            timer?.invalidate()
            isRunning = false
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    isRunning = false
                    switchTimerMode()
                }
            }
            isRunning = true
        }
    }

    func resetTimer() {
        timer?.invalidate()
        isRunning = false
        timeRemaining = isWorkTime ? 25 * 60 : 5 * 60
    }

    func switchTimerMode() {
        isWorkTime.toggle()
        timeRemaining = isWorkTime ? 25 * 60 : 5 * 60
    }

    func switchTimerModeManually() {
        timer?.invalidate()
        isRunning = false
        switchTimerMode()
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
