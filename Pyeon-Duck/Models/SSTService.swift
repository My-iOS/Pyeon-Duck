//
//  SSTService.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 1/2/24.
//

import Foundation
import Speech

class SSTService {
    static let shared = SSTService()
    
    // 한국어(ko-KR) 를 인식
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    // 오디오 데이터를 인식기에 전달하는 데 사용
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // 음성인식
    // 현재 음성 인식 작업 추적
    var recognitionTask: SFSpeechRecognitionTask? // 인식결과
    // 오디오 입력을 관리
    let audioEngine = AVAudioEngine()
}

extension SSTService {
    func startRecording(completion: @escaping (String) -> Void, stopHandler: @escaping (Bool) -> Void, placeHandler: @escaping (String) -> Void) {
        // 기존 작업이 있다면, 취소하고 nil로 초기화
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
            
        // 오디오 녹음 환경 설정
        let audioSession = AVAudioSession.sharedInstance()
        
        // 오디오 세션 설정
        do {
            try audioSession.setCategory(AVAudioSession.Category.record) // 녹음
            try audioSession.setMode(AVAudioSession.Mode.measurement) // 측정
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation) // 활성화
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
            
        // 음성데이터를 인식기에 전달할 준비
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        // 오디오 입력 노드 설정 : 오디오 엔진의 입력 노드를 참조, 오디오 데이터를 인식 요청에 연결
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
            
        // 인식 요청 설정
        recognitionRequest.shouldReportPartialResults = true
            
        // 음성 인식 작업 시작
        // recognitionTask 생성
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                
            var isFinal = false
                
            // 인식 결과가 있으면, TextView 표시
            if result != nil {
                completion(result?.bestTranscription.formattedString ?? "N/A")
                isFinal = (result?.isFinal)!
            }
                
            // 오류가 발생하거나 인식이 완료되면 오디오 엔진을 정지, 노드에서 탭을 제거
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                    
                self.recognitionRequest = nil
                self.recognitionTask = nil
                stopHandler(true)
            }
        })
            
        // 오디오 데이터 스트림 처리
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
            
        // 오디오 엔진 준비 및 시작
        audioEngine.prepare()
            
        // 사용자 안내 메시지 표시
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        placeHandler("말해보세요. 듣고 있어요!")
    }
}
