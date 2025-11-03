import Foundation

final class DaySelectorViewModel {
    let days = ["SEG", "TER", "QUA", "QUI", "SEX", "SAB", "DOM"]
    private let calendar = Calendar.current
    
    var selectedIndex: Int {
        let weekday = calendar.component(.weekday, from: Date())
        return (weekday + 5) % 7
    }
    
    var onDaySelected: ((Int) -> Void)?
    
    func selectDay(at index: Int) {
        onDaySelected?(index)
    }
}
