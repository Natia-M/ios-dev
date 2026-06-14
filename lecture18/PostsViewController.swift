import UIKit

class PostsViewController: UIViewController {
    
    var tableView = UITableView()
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Posts"
        
        setupTableView()
        fetchPosts()
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    func fetchPosts() {
        NetworkService.shared.fetchPosts { posts in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = posts[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPost = posts[indexPath.row]
        
        let vc = CommentsViewController()
        vc.postId = selectedPost.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
