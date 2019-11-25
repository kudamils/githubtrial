#frozen_string_literal: true

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox

Given(/^User navigate to the homepage$/) do
  driver.navigate.to 'http://www.github.com'
end

When(/^User click on Login button$/) do
signin = driver.find_element(:xpath, '//a[@class="HeaderMenu-link no-underline mr-3"]')
signin.click
end

And(/^user fill username and password$/) do
  myemail= XXXXX
  mypassword= XXXX
  username = driver.find_element(:id, 'login_field')
  password = driver.find_element(:id, 'password')
  username.send_keys(myemail)
  password.send_keys(mypassword)
end

And(/^user click on sign in button$/) do
  signinbutton = driver.find_element(:class, 'btn-primary')
  signinbutton.click
end

And(/^user navigate to gist page$/) do
  # driver.navigate.to 'https://gist.github.com'
  dropdownmenu = driver.find_element(:xpath, '//div[@class="Header-item position-relative d-none d-lg-flex"]')
  dropdownmenu.click
  newgist = driver.find_element(:xpath, '//a[contains(text(),"New gist")]')
  newgist.click
end

And(/^create a public gist$/) do
  puts "Test create new gist"
  gistdesc = driver.find_element(:name, 'gist[description]')
  gistdesc.send_keys "New Gist"
  sleep(5)
  filenameext = driver.find_element(:name, 'gist[contents][][name]')
  filenameext.send_keys "Trialnewgist.txt"
  presentation = driver.find_element(:class, ' CodeMirror-line')
  presentation.click
  presentation.send_keys "This is my first gist"
  sleep(5)
  createpubgistBtn = driver.find_element(:name, 'gist[public]')
  createpubgistBtn.click
end

And(/^validate gist created$/)do
  fileinfo = wait.until {
    filename = browser.find_element(:class, 'file-info')
    filename if filename.displayed?}
  puts "Test Passed: New Gist File created" if fileinfo.displayed?
end

And(/^edit an existing public gist$/) do
  editBtn = driver.find_element(:class, 'btn.btn-sm')
  editBtn.click
  gistdesc = driver.find_element(:name, 'gist[description]')
  gistdesc.send_keys " Edit Gist"
  filenameext = driver.find_element(:name, 'gist[contents][][name]')
  filenameext.send_keys "trialeditgist.txt"
  codebody = driver.find_element(:class, 'CodeMirror-scroll')
  codebody.send_keys "EDIT my gist"
  indentmode = driver.find_element(:id, 'indent-mode')
  indentmode.click
  indentchoosen = driver.find_element(:value, "tab")
  indentchoosen.click
  indentsize = driver.find_element(:id, 'indent-size')
  indentsize.click
  indentsizechoosen = driver.find_element(:value, "2")
  indentsizechoosen.click
  linewrapmode = driver.find_element(:id, 'line-wrap-mode')
  linewrapmode.click
  linewrapchoosen = driver.find_element(:value, "off")
  linewrapchoosen.click
  updateBtn = driver.find_element(:class, 'btn.btn-primary')
  updateBtn.click
  fileinfo = wait.until {
    filename = browser.find_element(:class, 'file-info')
    filename if filename.displayed?
  }
  puts "Test Passed: Gist File Edited" if fileinfo.displayed?
end

And(/^delete an existing gist$/) do
  deleteBtn = driver.find_element(:class, 'btn.btn-sm.btn-danger')
  deleteBtn.click
  driver.switch_to.alert.accept
  deleteGist = driver.find_element(:xpath, "//*[text()='Gist deleted successfully.']")
  deleteGist.displayed?
end

And(/^see my list of gists$/) do
  profile = driver.find_element(:class, 'Header-link name')
  profile.click
  yourGist = driver.find_element(:xpath, "//*[text()='Your gists']")
  yourGist.click
  allGist = driver.find_element(:xpath, "//*[text()='All gists']")
  allGist.displayed?
end