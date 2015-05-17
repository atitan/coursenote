#中原大學選課大全


## 安裝使用

**先確認Ruby和Bundler已安裝**

``` bash
$ ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
$ bundle show
Gems included by the bundle:
...以下略
```

**安裝相關套件並建立DB**

``` bash
$ bundle install
$ rake db:migrate
```

**匯入課程資料**

``` bash
$ rake data:import[1022]
$ rake data:import[1031]
$ rake data:import[1032]
$ rake data:import[....]
```

**啟動server**

``` bash
$ rails server
=> Booting Puma
=> Rails 4.2.0 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
```


## License

本專案使用[MIT License](http://www.opensource.org/licenses/MIT)授權。
