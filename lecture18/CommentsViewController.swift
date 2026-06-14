//
import UIKit

class CommentsViewController: UIViewController {
    
    var postId: Int?
    var tableView = UITableView()
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Comments"
        
        setupTableView()
        fetchComments()
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    func fetchComments() {
        guard let postId = postId else { return }
        
        NetworkService.shared.fetchComments(postId: postId) { comments in
            self.comments = comments
            self.tableView.reloadData()
        }
    }
}

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let comment = comments[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(indexPath.row + 1). \(comment.body)"
        
        return cell
    }
}
