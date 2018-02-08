# OCP9


# Le Baluchon Bonus

## Concept
Le Baluchon est une application visant à faciliter le voyage de l'utilisateur en lui fournissant des informations météo, un convertisseur de taux de change et un traducteur automatique

## Bonus

Les bonus de l'application sont les suivants :

1. Une page de reglage permettant de choisir devise, langue, et localisation pour le pays hôte et le pays de départ
2. Un Convertisseur de devise
3. L'auto-detection du langage de l'utilisateur à la saisie du texte à traduire

## User Settings

### Creation des MVC

Nous créons une la structure MVC suivante pour le user settings

![schema](/Users/mathieujanneau/Desktop/Untitled presentation (1).png)


L'acceuil des user settings est présenté ainsi
![home](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 20.38.05.png)

Chaque paramètre donne accès à une page de reglages dédiés. Les possibilités sont présentées dans une tableView.

![table](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 20.38.16.png)

L'etat de "highlight" de la cellule a été customisé. Un background blanc, une couleur complémentaire et un checkMark pour signalé la sélection.

<pre><code>
func highlight(_ cell: UITableViewCell, with color: UIColor){
// Set the higlight color scheme
cell.tintColor = color
cell.textLabel?.textColor =  color
// Set cell background to white
cell.backgroundColor = .white
let bgColorView = UIView()
bgColorView.backgroundColor = UIColor.white
cell.selectedBackgroundView = bgColorView
// add a check mark
cell.accessoryType = .checkmark
}</pre></code>

Selon l'univers "home" ou "away", le schema est coloriel est différent.
Pour cela un initialiseur complémentaire est ajouté dans les view Controller de settings
<pre><code>  func initDetail(bgColor:UIColor, txtSelect: UIColor, destination: String){
self.backgroundColor = bgColor
self.selectedTextColor = txtSelect
self.source = destination
}
</pre></code>

Le schema coloriel est lui initialisé dans le general user Settings au moment ou l'utilisateur sélectionne une propriété à modifier. Ensuite le ViewController push les settings ViewController

<pre><code>  @IBAction func goToCurrencySettings(_ sender: UIButton) {
currencyListVc.initDetail(bgColor: #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1), txtSelect: #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1), destination: "away")
navigationController?.pushViewController(currencyListVc, animated: true)
}  </pre></code>

Présentation des schémas coloriels

**AWAY**

![](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 20.38.16.png)

**HOME**

![](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 20.38.26.png)

### Stockage des préférences

Les préférences sont stockées dans le user défault du téléphone.
<pre><code> static let defaults = UserDefaults.standard</pre></code>
Pour cela un User Settings manager est crée.
Il permet de:

1. sauver des options
2. charger des options
3. reinitialiser les options

Au moment ou l'application se lance, les préférences son rechargées.

Afin de bien signaler à l'utilisateur quelles sont les options choisies, quand il entre dans un settingsController son choix est mis en surbrillance. Pour cela nous sauvons l'Integer de l'indexPath.row au moment du choix et le rappelons au moment du viewWillAppear des tableView.

<pre><code> if source == "home" { // home
selectedHome = UserSettings.loadData(displayKey: homeDisplayKey, indexKey: homeIndexKey).1
home = dataSet[selectedHome!][value]!
selectRow(selectedHome!)
} else { // away
selectedAway = UserSettings.loadData(displayKey: awayDisplayKey, indexKey: awayIndexKey).1
away = dataSet[selectedAway!][value]!
selectRow(selectedAway!)
}</pre></code>

### Localization Settings
Les models pour le languageSettings et le CurrencySettings sont des structs figés en local.
Cependant afin d'offrir une meilleur expérience dans le location settings nous fournissons une interface de recherche qui fait appel à une API extérieure : openStreetMap

[documentation de l'API openStreetMap](https://wiki.openstreetmap.org/wiki/Nominatim)

Afin de réaliser les REST API CALL nous utilisons le framework Alamofire.

[Repo Github Alamofire & Documentation](https://github.com/Alamofire/Alamofire)

L'installation s'est faite via cocoaPods

Tous les appels aux API REST sont fait sur la thread en background.
En pratique l'utilisateur, la recherche s'effectue ainsi :


1. L'utilisateur entre le nom d'une ville.
2. il appuie sur la touche entrée.
3. Toutes les propositions sont présentées.
4. Il sélectionne sa ville (elle est alors stockées dans le user defaults)

![](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 21.07.38.png)

La validation par la touche entrée ou une touch en dehors du clavier se fait via le UITextField Delegate.

**Nous overridons 2 fonctions :**

<pre><code>  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
searchLocation()
table?.isHidden = false
input?.resignFirstResponder()
self.view.endEditing(true)
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
searchLocation()
table?.isHidden = false
self.input?.resignFirstResponder()
return (true)
}</pre></code>

La fonction searchLocation() effectue la requete vers L'API via Alamofire.

## Le convertisseur de devise

![Convertisseur](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 21.14.52.png)

Le convertisseur est en 3 parties :

1. Un clavier permettant d'effectuer les opérations en partie basse
2. Un affichage des valeurs au milieu
3. Un affichage du taux de change en vigueur et la date du jour

Le model du convertisseur est conenu dans le fichier CurrencyConverter.swift. Ce fichier héberge une structure qui gère toutes les opérations et la logique.
Nous faisons le choix d'une structure pour des raisons de mémoires et nous choisissons donc un objet par valeur.

La gestion des boutons est via une collection d'outlet qui renvoie le contenu du *button.titleLable.text.*

Puis cette valeur est stocké dans un table de [String] nommé stringNumbers

Quand l'utilisateur appuie sur la touche convert, il fait appel à la fonction convert() du model

La fonction de conversion est la suivante :
<pre><code>  mutating func convert(rate:Double) -> Double {
var total: Double = 0
// slices the memorized number
for stringNumber in stringNumbers {
//Convert string into Int to calculate
if let number = Double(stringNumber) {
total = number * rate
}
}
clear()
return total
}</pre></code>

## Autodetection du langage

### Implementation graphique

L'autodetection est activée via un switch sur l'onglet traduction

![](/Users/mathieujanneau/Desktop/Capture d’écran 2018-02-08 à 22.22.09.png)

Quand celui ci est activé, la langue du pays de départ est changée en fonction du texte entré dans le textField Input.

### Model

La fonction detectLanguage() est implémentée dans le model translationService.


Cette fonction prend en paramètre une string : le texte à traduire.

Celle-ci repose sur une requete vers L'API google translate avec les paramètres suivants :
<pre><code>guard let urlEncodedText = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
let request = "https://translation.googleapis.com/language/translate/v2/detect?key=\(TranslationService.API_KEY)&q=\(urlEncodedText)"</pre></code>

Le guard statement permet d'éviter une url non valide.

La requete est effectuée grâce à Alamofire et dispatchée sur une background queue afin de ne pas ralentir l'affichage de l'UI.

ce dernier 'escape'/retourne une string représentant le langage reconnu.


