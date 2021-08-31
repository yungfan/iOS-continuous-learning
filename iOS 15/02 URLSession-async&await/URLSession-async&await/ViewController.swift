//
//  ViewController.swift
//  URLSession-async&await
//
//  Created by 杨帆 on 2021/7/20.
//

import UIKit

class ViewController: UIViewController {
    let session = URLSession.shared
    // 上传前缀
    let YFBoundary = "AnHuiWuHuYungFan"
    // 显示下载的图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = view.center
        return imageView
    }()

    // 显示新闻标题
    lazy var newsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
        return tableView
    }()

    // UITableView数据源
    var dataSource = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(newsTableView)
        get()

        // view.addSubview(imageView)
        // upload()
    }

    // 获取数据
    func get() {
        Task {
            do {
                let news = try await getNews(from: URL(string: "http://rap2api.taobao.org/app/mock/data/1772974")!)
                for n in news {
                    dataSource.append(n)
                }
                newsTableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // 下载
    func download() {
        Task {
            do {
                let image = try await downloadFile(from: URL(string: "http://192.168.0.97:8080/AppTestAPI/wall.png")!)
                imageView.image = image
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // 上传
    func upload() {
        Task {
            do {
                let resonpse = try await uploadFile(to: URL(string: "http://192.168.0.97:8080/AppTestAPI/UploadServlet")!)
                print(resonpse)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController {
    func getNews(from url: URL) async throws -> [News] {
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(NewsModel.self, from: data).result
    }
}

extension ViewController {
    func downloadFile(from url: URL) async throws -> UIImage {
        let (localURL, _) = try await session.download(from: url)
        let savePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileName = "\(Int(Date.now.timeIntervalSince1970)).png"
        let filePath = savePath + "/" + fileName
        try FileManager.default.moveItem(at: localURL, to: URL(fileURLWithPath: filePath))
        return UIImage(contentsOfFile: filePath)!
    }
}

extension ViewController {
    func uploadFile(to url: URL) async throws -> URLResponse {
        var request = URLRequest(url: url)
        let head = "multipart/form-data;boundary=\(YFBoundary)"
        request.setValue(head, forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var data = Data()
        let header = headerString(mimeType: "image/png", uploadFile: "iOS15.png")
        data.append(header.data(using: .utf8)!)
        data.append(uploadData())
        let tailer = tailerString()
        data.append(tailer.data(using: .utf8)!)
        let (_, response) = try await session.upload(for: request, from: data)
        return response
    }

    // 开始标记
    func headerString(mimeType: String, uploadFile: String) -> String {
        var data = String()
        data.append("--" + YFBoundary + "\r\n")
        data.append("Content-Disposition:form-data; name=\"myfile\";filename=\"\(uploadFile)\"\r\n")
        data.append("Content-Type:\(mimeType)\r\n\r\n")
        return data
    }

    // 结束标记
    func tailerString() -> String {
        return "\r\n--" + YFBoundary + "--\r\n"
    }

    // 上传内容
    func uploadData() -> Data {
        let image = UIImage(named: "iOS15.png")
        let imageData = image!.pngData()
        return imageData!
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        cell?.textLabel?.text = dataSource[indexPath.row].title
        return cell!
    }
}
