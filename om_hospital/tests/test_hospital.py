from odoo.tests.common import TransactionCase
from odoo.tests import tagged

# @tagged("-at_install", "post_install")
class TestHospital(TransactionCase):

    def setUp(self, *args, **kwargs):
        super(TestHospital, self).setUp(*args, **kwargs)
        self.test_patient = self.env['hospital.patient'].create({'name': 'John Doe',
                                                                 'age': 50,
                                                                 'gender': 'male',
                                                                 'note': 'bike accident',
        })
        
        self.test_doctor = self.env['hospital.doctor'].create({'doctor_name': 'Johnny',
                                                               'age': 36,
                                                               'gender': 'male',
                                                               'note': 'A highly skilled doctor at bike accidents',
                                                               'active': True,
        })

        self.test_appointment = self.env['hospital.appointment'].create({'name':'John Doe',
                                                 'patient_id': self.test_patient.id,
                                                 'age': 50,
                                                 'doctor_id': self.test_doctor.id,
                                                 'gender': 'female',
                                                 'state': 'draft',
                                                 'note': 'some accident',
                                                 'date_appointment': '2012-04-23',
                                                 'date_checkup': '2012-05-23 05:30:00',
                                                 'prescription': 'drugs',

        })

    def test_compute_appointment_count(self):
        self.test_patient._compute_appointment_count()
        self.assertEqual(self.test_patient.appointment_count, 1, "Appointment count should be value: 1")

        self.test_doctor._compute_appointment_count()
        self.assertEqual(self.test_doctor.appointment_count, 1, "Appointment cound should be value: 1")

    def test_get_name(self):
        name = self.test_patient.name_get()
        self.assertEqual(name[0][1], f'[{self.test_patient.reference}] John Doe', 'Name should be equal to "[Reference Num] John Doe"')

    def test_patient_actions(self):
        self.test_patient.action_confirm()
        self.assertEqual('confirm', self.test_patient.state, "State should be value: confirm")
        self.test_patient.action_done()
        self.assertEqual('done', self.test_patient.state, "State should be value: done")
        self.test_patient.action_cancel()
        self.assertEqual('cancel', self.test_patient.state, "State should be value: cancel")
        self.test_patient.action_draft()
        self.assertEqual('draft', self.test_patient.state, "State should be value: draft")
    
    def test_onchange_id(self):
        self.test_appointment.onchange_patient_id()
        self.assertEqual(self.test_appointment.gender, 'male', "State should be value: male")
        self.assertEqual(self.test_appointment.note, 'bike accident', "State should be value: bike accidnet")

    def test_unlink(self):
        self.test_appointment.unlink()
        self.assertEqual(0, self.test_patient.appointment_count, "Appointment count should be value: 0")