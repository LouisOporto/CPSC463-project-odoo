from odoo.tests.common import TransactionCase

class TestHospitalDoctor(TransactionCase):

    def setUp(self, *args, **kwargs):
        super(TestHospitalDoctor, self).setUp(*args, **kwargs)

    # def test_upper(self):
    #     self.assertNotEqual('foo'.upper(), 'FOO')

    # def test_isupper(self):
    #     self.assertTrue('FOO'.isupper(), 'Testing: Should be true')
    #     self.assertFalse('foo'.islower(), 'Testing: Should be false')

    # def test_split(self):
    #     s = 'hello world'
    #     self.assertEqual(s.split(), ['hello', 'world'])
    #     with self.assertRaises(TypeError):
    #         s.split(2)