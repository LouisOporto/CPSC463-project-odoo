from odoo.tests import tagged
from odoo_selenium import SeleniumCase

from selenium.webdriver.common.by import By

@tagged("-at_install", "post_install")
class TestHospitalDoctor(SeleniumCase):

    def setUp(self, *args, **kwargs):
        super(TestHospitalDoctor, self).setUp(*args, **kwargs)


    def test_login(self):
        self.navigate("/web/login")
        email_input = self.driver.find_element(By.ID, "login")
        email_input.send_keys("louisoporto042@csu.fullerton.edu")
        password_input = self.driver.find_element(By.ID, "password")
        password_input.send_keys("odoo15")
        login_button = self.driver.find_element(By.ID, "submit")
        login_button.click()
        self.assertTrue(self.driver.find_element(By.ID, "user_menu").is_displayed())

    # def test_isupper(self):
    #     self.assertTrue('FOO'.isupper(), 'Testing: Should be true')
    #     self.assertFalse('foo'.islower(), 'Testing: Should be false')

    # def test_split(self):
    #     s = 'hello world'
    #     self.assertEqual(s.split(), ['hello', 'world'])
    #     with self.assertRaises(TypeError):
    #         s.split(2)