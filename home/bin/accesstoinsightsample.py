#!/usr/bin/env python

import time

def log_error(err):
    with open("/tmp/accesstoinsightsample_error.log", "a") as f:
        f.write(err)

try:

    from selenium import webdriver
    from selenium.webdriver.common.by import By
    from selenium.common.exceptions import NoSuchElementException
    import re
    import random
    import traceback

    # Create a headless browser
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    browser = webdriver.Chrome('/usr/lib/chromium-browser/chromedriver', chrome_options=options)

    # Open the webpage
    while True:
        try:
            url = "https://www.accesstoinsight.org/index-similes.html"
            browser.get(url)
            break
        except:
            log_error(traceback.format_exc())
            time.sleep(5)
            pass

    # Find the links that match the regex
    regex = "(DN|Sn|Dhp|MN|AN|Thig|Ud|Miln).+"
    links = browser.find_elements(By.TAG_NAME, "a")
    matching_links = list(filter(lambda link: re.search(regex, link.text), links))

    # Select a random matching link
    random_link = random.choice(matching_links)
    random_link.click()

    # Wait for the subsequent page to finish loading
    # browser.implicitly_wait(5)

    # Print out the text from the element with class "chapter"
    chapter_element = None
    verse_element = None
    try:
        chapter_element = browser.find_element(By.CLASS_NAME, "chapter")
    except NoSuchElementException:
        log_error('no chapter element found')
    try:
        verse_element = browser.find_element(By.CLASS_NAME, "verse")
    except NoSuchElementException:
        log_error('no chapter element found')
    if verse_element:
        txt = verse_element.text
    else:
        txt = chapter_element.text
    if type(txt) != str:
        txt = txt.encode('utf-8')
    print(' '.join(txt.split('\n')))

    # Close the browser
    browser.quit()

except Exception as e:
    log_error(traceback.format_exc())
    sys.exit(1)

