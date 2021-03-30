const BASEURL = "https://getcure.herokuapp.com";

// list of endpoints:

// I) no Authorization=>
const OTP = BASEURL +
    "/generate-otp"; // (post request to generate random otp) (body: { mobile_no: string })
const SIGNUP = BASEURL +
    "/register"; //(post request to signup or register doctor) (body: { mobile_no: string, password: string, otp: string})
const LOGINDOCTOR = BASEURL +
    "/login-doctor"; //(post request to login) (body: {emailOrPhone: string, password: string})
const LOGINFRONTDESK = BASEURL +
    "/login-front-desk"; // (post request to login) (body: {emailOrPhone: string, password: string})

// II) DOCTOR=>
const GETDOCTOR =
    BASEURL + "/my-doctor-profile"; // (get request to show my details)
const UPDATEDOCTOR = BASEURL + "/my-doctor-profile";
// (put request to update my details) (body: {name?: string; email?: string;  mobile_no?: string;  password?: string;
//   								   alternate_no?: string;  gender?: string;  university?: string;
//   								   experience?: string;  qualification?: string;  consultation_fee?: number;
//   								   emergency_fee?: number;  speciality?: string;
//   									address?: string;  information?: string; })
const DELETEDOCTOR =
    BASEURL + "/my-doctor-profile"; // (delete request to soft delete me)
const UPDATECLINIC = BASEURL +
    "/my-clinic-timing/+clinicId"; // (put request to add/update my clinic timings) (body: {doctor_timings: Timing[];
//patients_per_hour: number;}) here Timing represents array of object=> {day: DaysEnum; start_time: string;  end_time: string;  break_start?: string;  break_end?: string;}

const MYCLINICS = BASEURL + "/my-clinics";

// III) CLINIC=>
const ADDCLINIC = BASEURL +
    "/add-clinic"; //(post req to add clinic) (body: {name: string;  city_id: number;  city: string;  address: string;  landmark?: string;
//pin_code: string;  phone_no: string;  timings: Timing[]; emergency_fee: float; consultaion_fee: float;  registration_no?: string;}) here Timing is same as above object
const ADDCLINICBYCODE = BASEURL +
    "/add-clinic-by-code"; //(post request to add clinic by code) (body: {clinic_code: string})

// IV) FRONT DESK =>
const GETFRONTDESK =
    BASEURL + "/my-front-desk"; //(get request to view my front desk profile)
const UPDATEFRONTDESK = BASEURL +
    "/my-front-desk"; //(put request to update my front desk profile) (body: {name?: string;  email?: string;  mobile_no?: string;
// alternate_no?: string;  password?: string;  gender?: string;  address?: string;  information?: string;})

// V) TOKEN =>
const GETTOKENSBYDATE = BASEURL +
    "/booked-tokens/"; //(get request to view appointments by date in query params)
const TOKENSBOOKING = BASEURL +
    "/token/doctor/book"; // (post api to create appointment) (body: {(patient_id: number OR patient: {name: string, age: number, address, gender[male, female], mobile_no}),
//	appointment_type: [general, emergency], visit_type: [new visit, follow up], booking_type: [walk in, on call]})
const DELETETOKEN =
    BASEURL + "/tokens/+tokenId"; // (delete request to delete appointment)

// VI) ADDRESS =>
const GETSTATES = BASEURL + "/states"; //(get api to view all states)

const ACTIVESTATES = BASEURL + "/active-states";
const CLINICSBYSTATES = BASEURL + "/clinics-by-state/"; //(get api to view all states)
const GETCITIES =
    BASEURL + "/cities/+stateId"; // (get api to view cities of a state)
const GETSPECIAL = BASEURL + "/specialities";
// VII) INVOICE =>
const GETDOCINVO =
    BASEURL + "/doctors-invoice/"; //(get api to view invoice in decr date)
const GETHOSINVO = BASEURL +
    "/clinics-invoice/"; //(get api to view invoice of clinic)(body: {date: YYYY-MM-DD})

//VIII) SYMPTOMS =>
const GETBRIEFHISTORY = BASEURL + "/brief-histories"; // (get api) (doc token)
const GETVISITREASON = BASEURL + "/visit-reasons"; // (get api) (doc token)
const ADDSYMPTOM = BASEURL +
    "/symptom"; //(post api) (doc token) (body: {doctor_id: number; title: string; type: [Visit Reason, Brief History]})
const DELETESYMPTOM =
    BASEURL + "/symptom/(+symptomId)"; //(delete api) (doc token)

//IX) EXAMINATION =>
const GETEXAMINATION = BASEURL + "/examinations"; //(get api) (doc token)
const ADDEXAMINATION = BASEURL +
    "/examinations"; //(post api) (doc token) (body: {doctor_id: number; title: string; parameters: Parameter[]; price?: number}) here Parameter is {title: string, within_range: number[]};
//const changeit = BASEURL+"/examinations/(+examinationId)"; //(doc token) (put api) (body: {title, parameters, price} => not compulsory)
const DELETEEXAMINATION =
    BASEURL + "/examinations/(+examinationId)"; // (doc token) (delete api)

//20)
const BRIEFHISTORY = BASEURL + "/brief-histories"; //(get api) (doc token),
//21)
const VISITREASON = BASEURL + "/visit-reasons"; //(get api) (doc token),
//22)
const POSTSYMPTOM = BASEURL +
    "/symptom"; //(post api) (doc token) (body: {doctor_id: number; title: string; type: [Visit Reason, Brief History]}),
//23)
const DELETESYM = BASEURL + "/symptom/"; //(+symptomid) (delete api) (doc token)


// Data sync

const PATIENTVISITSYNC = BASEURL + "/patient-visits/bulk-create";
const PATIENTDATASYNC = BASEURL +"/patient/bulk-create";

const FEEDBACKSYNC = BASEURL +"/sync/feedbacks";
const MEDANALYSIS = BASEURL+"/medicine-analysis/";
const MEDICINESYNC = BASEURL+"/doctor-medicines";
const HABITSYNC = BASEURL+"/habits";
const SYMPTOMSSYNC = BASEURL+"/symptoms/bulk-create";
const EXAMINATIONSYNC = BASEURL+"/examinations/bulk-create";
const DISANALYSIS = BASEURL+"/disease-analysis/";
const DOCTORENJOYDAYE = BASEURL + "/my-doctor-profile/";
const DOCTORTIMING =BASEURL + "/my-clinic-timing/";
const DOCTORAPPOINTMENTHISTORY= BASEURL + "/visits/clinic-doctor/"; //:clinicDoctorId([0-9];
const DOCTORINVOICEAPI = BASEURL + "/doctors-invoice/"; //:clinicDoctorId([0-9]+)/doctor;
const UPDATEDOC = BASEURL + "/update-doctor/";
const IMAGEDOCUPLOAD = BASEURL + "/document-upload/"; //:type="id_verification" or type="clinic_ownership"
const CANCELTOKENFETCH = BASEURL + "/cancelled-tokens/"; //doc id?date=2020-11-29
const PARAMETERS = BASEURL + "/medicine-parameters/";
const CANCELBULK = BASEURL +"/cancel-bulk-tokens/";//clinic doc id
const PATIENTFEEDBACK = BASEURL +"/patient-feedback/";//clinic doc id
const FEESUPDATE = BASEURL + "/my-fees/" ; // :clinicDoctorId([0-9]+)"
