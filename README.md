#中原大學選課大全

[![Build Status](https://travis-ci.org/atitan/coursenote.svg?branch=master)](https://travis-ci.org/atitan/coursenote) [![Code Climate](https://codeclimate.com/github/atitan/coursenote/badges/gpa.svg)](https://codeclimate.com/github/atitan/coursenote) [![Test Coverage](https://codeclimate.com/github/atitan/coursenote/badges/coverage.svg)](https://codeclimate.com/github/atitan/coursenote/coverage)

## 系統需求

**Ruby 2.2以上**

**PostgreSQL 9.4以上**

**Redis**

## 安裝使用

**確認Ruby和Bundler已安裝**

``` bash
$ ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
$ gem install bundler
Successfully installed bundler-1.10.6
```

**確認PostgreSQL已安裝並啟動**

``` bash
$ which postgres
/usr/local/bin/postgres
$ ps aux | grep postgres
```

**安裝相關套件並建立DB**

``` bash
$ bundle install
$ createdb coursewiki
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
