from selenium.webdriver import Firefox
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support.expected_conditions import presence_of_element_located
from time import sleep
import time

def addProduct(category,position,quantity):
	driver.find_element(By.ID, category).find_element(By.TAG_NAME,"a").click()
	#target_container=wait.until(presence_of_element_located((By.ID, "category-description")))
	#print(target_container)
	targets=driver.find_elements(By.CLASS_NAME, "product-title")
	target=targets[position]
	target.click()
	target=wait.until(presence_of_element_located((By.ID, "quantity_wanted")))
	target.send_keys(Keys.DELETE,quantity)
	driver.find_element(By.CLASS_NAME, "add-to-cart").click()
	target=wait.until(presence_of_element_located((By.CLASS_NAME, "cart-content-btn")))
	sleep(1)
	target.find_element(By.CLASS_NAME, "btn-secondary").click()
	sleep(1)

driver = Firefox(executable_path='/bin/geckodriver')
wait = WebDriverWait(driver,15)
driver.maximize_window()
driver.get("http://localhost:5242")
sleep(2)

addProduct("category-10",0,"1")
addProduct("category-10",3,"2")
addProduct("category-10",2,"3")
addProduct("category-11",1,"4")
addProduct("category-11",3,"5")
addProduct("category-11",2,"6")
addProduct("category-11",4,"7")
addProduct("category-12",1,"8")
addProduct("category-12",4,"9")
addProduct("category-12",5,"3")

driver.find_element(By.CLASS_NAME, "cart-preview").find_element(By.TAG_NAME,"a").click()
sleep(3)
targets=driver.find_elements(By.CLASS_NAME, "remove-from-cart")
target=targets[5]
target.click()
sleep(3)
driver.find_element(By.CLASS_NAME, "user-info").find_element(By.TAG_NAME,"a").click()
sleep(3)
driver.find_element(By.CLASS_NAME, "no-account").find_element(By.TAG_NAME,"a").click()
sleep(3)

#firstname
driver.find_element(By.NAME, "firstname").send_keys("Selenium")
sleep(1)
#lastname
driver.find_element(By.NAME, "lastname").send_keys("Bot")
sleep(1)
#email
driver.find_element(By.NAME, "email").send_keys("selenium{}@local.host".format(time.time()))
sleep(1)
#password
driver.find_element(By.NAME, "password").send_keys("Feler")
sleep(1)
#birthday
driver.find_element(By.NAME, "birthday").send_keys("2020-11-11")
sleep(1)
#psgdpr
driver.find_element(By.NAME, "psgdpr").click()
sleep(1)
#conditions_to_approve[terms-and-conditions]
driver.find_element(By.NAME, "customer_privacy").click()
sleep(1)

#form-control-submit
driver.find_element(By.CLASS_NAME, "form-control-submit").click()
sleep(1)

driver.find_element(By.CLASS_NAME, "cart-preview").find_element(By.TAG_NAME,"a").click()
sleep(1)
driver.find_element(By.CLASS_NAME, "cart-detailed-actions").find_element(By.TAG_NAME,"a").click()
sleep(1)

#address1
driver.find_element(By.NAME, "address1").send_keys("Selenium Street 5")
sleep(1)
#postcode
driver.find_element(By.NAME, "postcode").send_keys("11-111")
sleep(1)
#city
driver.find_element(By.NAME, "city").send_keys("Selenium City")
sleep(1)
#confirm-addresses
driver.find_element(By.NAME, "confirm-addresses").click()
sleep(1)
#payment-option-1-container
driver.find_element(By.ID, "payment-option-1").click()
sleep(1)
#conditions_to_approve[terms-and-conditions]
driver.find_element(By.NAME, "conditions_to_approve[terms-and-conditions]").click()
sleep(1)
#payment-confirmation
driver.find_element(By.ID, "payment-confirmation").find_element(By.TAG_NAME, "button").click()
sleep(1)

driver.find_element(By.CLASS_NAME, "user-info").find_element(By.CLASS_NAME,"account").click()
sleep(1)

#history-link
driver.find_element(By.ID, "history-link").click()
sleep(1)
#order-actions
driver.find_element(By.CLASS_NAME, "order-actions").find_element(By.TAG_NAME,"a").click()
sleep(1)
status=wait.until(presence_of_element_located((By.ID, "order-history"))).find_element(By.TAG_NAME, "span").text

print(status)
print(driver.current_url)
sleep(10)
driver.quit()

