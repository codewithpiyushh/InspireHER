import 'package:flutter/material.dart';
import 'dart:math';
import '../l10n/app_localizations.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key? key}) : super(key: key);

  @override
  _FinancePageState createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  double emi = 0.0;

  final List<Map<String, dynamic>> schemes = [
    {
      'icon': 'https://www.bankofbaroda.in/a2hs/BOB-Identifier-192x192.png',
      'name': 'Pradhan mantri mudra yojana',
      'maxLoan': '10 lakhs',
      'interest': '9.40% p.a',
    },
    {
      'icon':
          'https://s3-symbol-logo.tradingview.com/punjab-natl-bank--600.png', // Replace with actual icon URL
      'name': 'Stand Up India Scheme',
      'maxLoan': '20 lakhs',
      'interest': '7 % p.a',
    },
    {
      'icon':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3Vrauo1vCIs0lcDMYRmSfr7KASyFwQSrJQeCP-SD9oyUEvvqZj8dj4IYlyfms0BBAmHE&usqp=CAU', // Replace with actual icon URL
      'name': 'SBI Stree shakti Yojana',
      'maxLoan': '25 lakhs',
      'interest': '11.9 % p.a',
    },
    {
      'icon':
          'https://discovertemplate.com/wp-content/uploads/2024/04/SBI.jpg', // Replace with actual icon URL
      'name': 'PM Formalisation of Micro Food Enterprises (PM-FME)',
      'maxLoan': '10 lakhs',
      'interest': '8 % p.a',
    },
    {
      'icon':
          'https://trendlyne-media-mumbai-new.s3.amazonaws.com/profilepicture/1447_profilepicture.png', // Replace with actual icon URL
      'name': 'Animal Husbandry Infrastructure Development Fund (AHIDF)',
      'maxLoan': '2 cr',
      'interest': '6 % p.a',
    },
    {
      'icon':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROthoFVMSrZOm8xbYIKN-H0RAkWJ_SlvUW_89cbYCpfwp_2XjNNyzsxPfEIL4jZ0WriIg&usqp=CAU', // Replace with actual icon URL
      'name': 'SBI Stree shakti Yojana',
      'maxLoan': '25 lakhs',
      'interest': '9.50%-10.25%',
    },
    // ... (keep the existing schemes)
  ];

  final List<Map<String, dynamic>> investmentOptions = [
    {
      'name': 'Fixed Deposit',
      'returns': '5.5% - 7.5% p.a',
      'minAmount': '₹1,000',
      'duration': '7 days - 10 years',
    },
    {
      'name': 'Mutual Funds',
      'returns': '12-15% p.a (Expected)',
      'minAmount': '₹500',
      'duration': 'Flexible',
    },
    {
      'name': 'Public Provident Fund',
      'returns': '7.1% p.a',
      'minAmount': '₹500',
      'duration': '15 years',
    },
    {
      'name': 'National Pension System',
      'returns': '8-10% p.a (Expected)',
      'minAmount': '₹500',
      'duration': 'Until retirement',
    },
    // ... (keep the existing investment options)
  ];

  void calculateEMI() {
    double p = double.parse(principalController.text);
    double r = double.parse(rateController.text) / (12 * 100);
    double t = double.parse(timeController.text) * 12;

    double emiAmount = p * r * pow(1 + r, t) / (pow(1 + r, t) - 1);

    setState(() {
      emi = emiAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.finance,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.loanSchemes,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: schemes.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return SchemeCard(
                      icon: schemes[index]['icon'],
                      name: schemes[index]['name'],
                      maxLoan: schemes[index]['maxLoan'],
                      interest: schemes[index]['interest'],
                    );
                  },
                ),
                SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.investmentOptions,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: investmentOptions.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return InvestmentCard(
                      name: investmentOptions[index]['name'],
                      returns: investmentOptions[index]['returns'],
                      minAmount: investmentOptions[index]['minAmount'],
                      duration: investmentOptions[index]['duration'],
                    );
                  },
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.loanCalculator,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: principalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.loanAmount,
                          border: OutlineInputBorder(),
                          prefixText: '₹ ',
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.interestRate,
                          border: OutlineInputBorder(),
                          suffixText: '%',
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: timeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.timePeriod,
                          border: OutlineInputBorder(),
                          suffixText: AppLocalizations.of(context)!.years,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: calculateEMI,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(AppLocalizations.of(context)!.calculateEMI),
                      ),
                      SizedBox(height: 16),
                      if (emi > 0)
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.monthlyEMI,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '₹ ${emi.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SchemeCard extends StatelessWidget {
  final String icon;
  final String name;
  final String maxLoan;
  final String interest;

  const SchemeCard({
    Key? key,
    required this.icon,
    required this.name,
    required this.maxLoan,
    required this.interest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(icon),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${AppLocalizations.of(context)!.maximumLoanAmount}: $maxLoan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${AppLocalizations.of(context)!.interestRate}: $interest',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Add contact functionality here
            },
            child: Text(
              AppLocalizations.of(context)!.contact,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvestmentCard extends StatelessWidget {
  final String name;
  final String returns;
  final String minAmount;
  final String duration;

  const InvestmentCard({
    Key? key,
    required this.name,
    required this.returns,
    required this.minAmount,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.expectedReturns,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    returns,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.minimumAmount,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    minAmount,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.duration}: $duration',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
