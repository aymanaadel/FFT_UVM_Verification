#include <iostream>
#include <complex>
#include <cmath>
#include <cstdint>
#include <bitset>
using namespace std;

const double PI = 3.14159265358979323846;


// Function to perform FFT
void fft(std::complex<double>* x, int N) {
    if (N <= 1) return;
    std::complex<double> *even = new std::complex<double>[N/2];
    std::complex<double> *odd = new std::complex<double>[N/2];
    for (int i = 0; i < N/2; ++i) {
        even[i] = x[2*i];
        odd[i] = x[2*i+1];
    }
    fft(even, N/2);
    fft(odd, N/2);
    for (int k = 0; k < N/2; ++k) {
        std::complex<double> t = std::polar(1.0, -2 * PI * k / N) * odd[k];
        x[k] = even[k] + t;
        x[k+N/2] = even[k] - t;
    }
    delete[] even;
    delete[] odd;
}

// Function to convert binary string to 16-bit signed integer
int16_t binaryStringToInt16(const std::string& binaryStr) {
    // Convert binary string to 16-bit signed integer
    return static_cast<int16_t>(std::bitset<16>(binaryStr).to_ulong());
}

// Function to convert input from binary (fixed-point) to double for FFT
void convertInputToDouble(std::complex<double>* x, const std::string* fixedPointRealBin, const std::string* fixedPointImagBin, int N) {
    for (int i = 0; i < N; ++i) {
        int16_t real = binaryStringToInt16(fixedPointRealBin[i]);
        int16_t imag = binaryStringToInt16(fixedPointImagBin[i]);
        double real_double = static_cast<double>(real) / 256.0; // Scale to double
        double imag_double = static_cast<double>(imag) / 256.0; // Scale to double
        x[i] = std::complex<double>(real_double, imag_double);
    }
}

extern "C" int check_output(char **in, char **Yr, char **Yi)
{
    double Y_Cpp_real;
    double Y_Cpp_imag;
    double Y_SV_real;
    double Y_SV_imag;
    int error_count = 0;
    const int N = 32;
    // input
    complex<double> Y_Cpp[N];
    // output
    complex<double> Y_SV[N];

    // input
    string x_real[N];
    string x_imag[N];
    // output
    string SV_real_out[N];
    string SV_imag_out[N];   

    for (int i = 0; i < N; ++i)
    {
        x_real[i] = in[i];
        x_imag[i] = "0"; // input x is real so imag part equals to  0
        SV_real_out[i] = Yr[i];
        SV_imag_out[i] = Yi[i];
    }
    
    // Convert SV output to double for comparing
    convertInputToDouble(Y_SV, SV_real_out, SV_imag_out, N);

    // Convert input to double for FFT
    convertInputToDouble(Y_Cpp, x_real, x_imag, N);

    // Perform FFT
    fft(Y_Cpp, N);

    // Convert FFT result back to 16-bit binary fixed-point and output
    for (int i = 0; i < N; ++i) {
        Y_Cpp_real = Y_Cpp[i].real();   Y_Cpp_imag = Y_Cpp[i].imag();
        Y_SV_real = Y_SV[i].real();     Y_SV_imag = Y_SV[i].imag();
    
        // comparing the design output with the reference model (+/- 0.1 due to little precision difference)
        if ( !(Y_Cpp_real-0.1 < Y_SV_real && Y_SV_real < Y_Cpp_real+0.1 && Y_Cpp_imag-0.1 < Y_SV_imag && Y_SV_imag < Y_Cpp_imag+0.1) )
            error_count++;
    }

        if (error_count==0) // if no errors
        {
            return 1;
        }
        else {
            return 0;
        }

}
