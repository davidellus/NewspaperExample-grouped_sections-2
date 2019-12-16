import UIKit
// PRIMA DI TUTTO
struct Headline {
    var id : Int
    var date : Date
    var title : String
    var text : String
    var image : String
}
extension UIView {
   // -  Mark funzione gradiente
    func insEffettoGradient(primoColore: UIColor, secondoColore: UIColor, terzoColore: UIColor?){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        if terzoColore == nil{
            
            gradientLayer.colors = [primoColore.cgColor, secondoColore.cgColor]
            gradientLayer.locations =  [0.0, 1.0]
        }
        else{
            gradientLayer.colors = [primoColore.cgColor, secondoColore.cgColor, terzoColore!.cgColor]
            gradientLayer.locations =  [0.0, 0.5, 1.0]
        }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

//Funzioni da inserire
private func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
}

private func parseDate(_ str : String) -> Date {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    return dateFormat.date(from: str)!
}

class StoriesTableViewController: UITableViewController {
    
    
    //359c108
    var headlines = [
        Headline(id: 1, date: parseDate("2018-02-10"), title: "Hospital", text: "Max goes to the Hospital", image: "Blueberry"),
        Headline(id: 2, date: parseDate("2018-02-15"), title: "Hospital", text: "Max got out from Hospital", image: "Blueberry"),
        Headline(id: 3, date: parseDate("2018-03-05"), title: "Funeral", text: "Max died due to an incidental fall", image: "Apple"),
        Headline(id: 4, date: parseDate("2018-04-05"), title: "Wedding", text: "Max's  widow is not anymore widow", image: "Banana"),
        Headline(id: 6, date: parseDate("2018-04-05"), title: "Wedding", text: "Max's  widow is not anymore widow", image: "Banana"),
        Headline(id: 3, date: parseDate("2018-03-05"), title: "Funeral", text: "Pie died due to an incidental fall", image: "Apple"),
        Headline(id: 4, date: parseDate("2018-04-05"), title: "Wedding", text: "Gian's  widow is not anymore widow", image: "Banana"),
        Headline(id: 4, date: parseDate("2018-04-05"), title: "Wedding", text: "Fur's  widow is not anymore widow", image: "Banana"),
    ]

    var sections = [GroupedSection<Date, Headline>]()

    // MARK: - View Controller lifecycle

    
    @IBOutlet var ImageView: UIImageView!
//    @IBOutlet var Button1: UIButton!
    
    var Button1 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Creo Bordi Alla SubView e al Bottone
        
            Button1.layer.cornerRadius = Button1.frame.size.height
        
        Button1.frame = CGRect(x: 250, y: 60, width: 70, height: 70)
//        Button1.insEffettoGradient(primoColore: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), secondoColore: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), terzoColore: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) )
            Button1.frame.size.height = Button1.frame.size.height
            Button1.layer.masksToBounds = true
            UIProva.layer.cornerRadius = UIProva.frame.size.height / 10
            UIProva.layer.masksToBounds = true
        
        let imageName = UIImage(named: "angry-grandma")
                ImageView = UIImageView(image: imageName!)
                ImageView.sizeToFit()
                ImageView.layer.masksToBounds = false
        //        ImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                ImageView.layer.borderColor = UIColor.black.cgColor
                ImageView.layer.cornerRadius = 13;
                ImageView.clipsToBounds = true
        
        view.sendSubviewToBack(view)
             //Richiamo metodo per creare effetto Gradient
//        UIProva.insEffettoGradient(primoColore: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), secondoColore: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), terzoColore: nil)
//        view.insEffettoGradient(primoColore: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), secondoColore: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), terzoColore: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
//
//        UIProva.sendSubviewToBack(UIProva)
        UIProva.addSubview(ImageView)
        self.sections = GroupedSection.group(rows: self.headlines, by: { firstDayOfMonth(date: $0.date) })
        self.sections.sort { lhs, rhs in lhs.sectionItem < rhs.sectionItem }
        
        ImageView.addSubview(Button1)


    }
    @IBOutlet var UIProva: UIView!
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.sectionItem
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: date)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.rows.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        let section = self.sections[indexPath.section]
        let headline = section.rows[indexPath.row]
        cell.backgroundColor = .gray
        cell.textLabel?.text = headline.title
        cell.detailTextLabel?.text = headline.text
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.imageView?.image = UIImage(named: headline.image)

        return cell
    }
    

}
