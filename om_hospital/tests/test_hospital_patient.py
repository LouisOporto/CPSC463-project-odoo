from odoo.tests.common import TransactionCase
from odoo.tests import tagged

# @tagged("-at_install", "post_install")
class TestHospitalPatient(TransactionCase):

    def setUp(self, *args, **kwargs):
        super(TestHospitalPatient, self).setUp(*args, **kwargs)
        self.test_patient = self.env['hospital.patient'].create({'name':'John Doe',
                                                                 'age': 50,
                                                                 'note': 'bike accident'})

    def test_compute_appointment_count(self):
        self.test_patient._compute_appointment_count()
        self.assertEqual(self.test_patient.appointment_count, 0, "Appointment count should be 0")

    def test_get_name(self):
        name = self.test_patient.name_get()
        self.assertEqual(name[0][1], f'[{self.test_patient.reference}] John Doe', 'Name should be equal to "[Reference Num] John Doe"')

    def test_open_appointments(self):
        result = self.test_patient.action_open_appointments()
        self.assertEqual(result['type'], 'ir.actions.act_window')
        self.assertEqual(result['name'], 'Appointments')
        self.assertEqual(result['res_model'], 'hospital.appointment')
        self.assertEqual(result['view_mode'], 'tree,form')
        self.assertEqual(result['target'], 'current')

    def test_is_draft(self):
        self.assertNotEqual('confirm', self.test_patient.state)
        self.assertNotEqual('done', self.test_patient.state)
        self.assertNotEqual('cancel', self.test_patient.state)
        self.assertEqual('draft', self.test_patient.state)