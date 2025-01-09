class Student {
  String? name;
  int? rollno;
  static String instituteName = "ABC University";
  bool paymentStatus = false;

  Student(this.name, this.rollno, {this.paymentStatus = false});

  void admissionProcedure() {
    print("-----------------------------------");
    print("Admission Procedure for $name");
    print("Fee Information: $instituteName fees.");
    print("Payment Status: ${paymentStatus ? 'Paid' : 'Pending'}");
    print("-----------------------------------\n\n");

  }

  void makePayment() {
    paymentStatus = true;
    print("\n\n-----------------------------------");
    print("$name has made the payment.");
    print("-----------------------------------\n\n");
  }

  void subjectSelection(String subject) {
    print("\n\n-----------------------------------");
    print("$name selected $subject as their subject.");
    print("-----------------------------------\n\n");
  }
}

class BCAStudent extends Student {
  String? minor;
  int? year;

  BCAStudent(name, rollno, {paymentStatus = false, this.minor, this.year})
      : super(name, rollno, paymentStatus: paymentStatus) {
    print("\n\n-----------------------------------");
    print("BCA Admission Procedure");
    print("-----------------------------------");
    admissionProcedure();
  }
}

class CommerceStudent extends Student {
  String? minor;
  int? year;

  CommerceStudent(name, rollno, {paymentStatus = false, this.minor, this.year})
      : super(name, rollno, paymentStatus: paymentStatus) {
    print("\n\n-----------------------------------\n\n");
    print("Commerce Admission Procedure");
    print("\n\n-----------------------------------");
    admissionProcedure();
  }
}

class InternshipCandidate extends BCAStudent {
  String? companyName;
  int? duration;
  int? stipend;

  InternshipCandidate(
      name, rollno, this.companyName, this.duration, this.stipend,
      {paymentStatus = false, specalization, year})
      : super(name, rollno);
}

void main() {
  BCAStudent student1 = BCAStudent(
    "John Doe",
    101,
    paymentStatus: true,
    minor: "Software Development",
    year: 2,
  );

  student1.subjectSelection("Computer Networks");
  student1.makePayment();

  CommerceStudent student2 =
      CommerceStudent("Alan Wake", 201, minor: "Accounting", year: 3);
  student2.subjectSelection("OCM");

  InternshipCandidate student3 =
      InternshipCandidate("Juliet", 303, "TCS", 20, 4000);
  student3.makePayment();
}
