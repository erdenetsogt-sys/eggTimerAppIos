import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var eggLayout: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var secondsPassed = 0
    var remainingSeconds = 60
    var timer = Timer()
    var percent: Float = 3.14
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
//        progressBar.setProgress(progressBar.progress + -1, animated: true)
        progressBar.progress = 0.0
        timer.invalidate()
        let hardness = sender.currentTitle!
        remainingSeconds = eggTimes[hardness]!
        eggLayout.text = hardness
        percent = 1 / ( Float(remainingSeconds) + 1.0)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime(){
        
        if remainingSeconds > 0 {
//            eggLayout.text = "\(remainingSeconds) seconds."
            remainingSeconds -= 1
            progressBar.setProgress(progressBar.progress + percent, animated: true)
        }else {
            timer.invalidate()
            progressBar.setProgress(progressBar.progress + percent, animated: true)
            eggLayout.text = "Done!"
            playSound()
        }
        
    }
    
    //ring mp3
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
        
    
    
}
    

