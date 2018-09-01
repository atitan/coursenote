# 中原大學選課大全

[![Build Status](https://travis-ci.org/atitan/coursenote.svg?branch=master)](https://travis-ci.org/atitan/coursenote) [![Code Climate](https://codeclimate.com/github/atitan/coursenote/badges/gpa.svg)](https://codeclimate.com/github/atitan/coursenote) [![Test Coverage](https://codeclimate.com/github/atitan/coursenote/badges/coverage.svg)](https://codeclimate.com/github/atitan/coursenote/coverage)

## 系統需求

**Ruby 2.3+**

**PostgreSQL 9.4+**

**Redis 2.8+**

## 安裝使用

**確認Ruby和Bundler已安裝**

``` bash
$ ruby -v
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
$ gem install bundler
Successfully installed bundler-1.16.4
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
$ bundle exec rails db:migrate
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
=> Rails 5.2.1 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
```


## License

本專案使用[MIT License](http://www.opensource.org/licenses/MIT)授權。
