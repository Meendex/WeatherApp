

URLSession.shared.dataTaskWith { data, task , response in

// parsing logic

tableView.relaodData()

}.resume()
