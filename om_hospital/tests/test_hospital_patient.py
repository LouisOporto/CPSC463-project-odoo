from odoo.tests.common import TransactionCase

class TestHospitalPatient(TransactionCase):

    def setUp(self, *args, **kwargs):
        super(TestHospitalPatient, self).setUp(*args, **kwargs)
        self.test_patient = self.env['hospital.patient'].create({'name':'John Doe',
                                                                 'age': 50,
                                                                 'note': 'bike accident'})

    def test_get_name(self):
        name = self.test_patient.name_get()
        self.assertEqual(name[0][1], f'[{self.test_patient.reference}] John Doe', 'Name should be equal to "[Reference Num] John Doe"')

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