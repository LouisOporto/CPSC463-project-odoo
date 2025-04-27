from odoo.tests.common import TransactionCase

class TestFooMethods(TransactionCase):
    def test_add(self):
        self.assertEqual(3, 1 + 2)
