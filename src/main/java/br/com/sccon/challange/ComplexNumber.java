package br.com.sccon.challange;

import lombok.*;

/**
 * A Class to represent a complex number (Z = X+Y*I)
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@EqualsAndHashCode
public class ComplexNumber {

    @NonNull
    private Long realPart = 0L;
    @NonNull
    private Long imaginaryPart = 0L;

    /**
    * Returns a sun between self complex number and another send by parameter
    * @param number {@link ComplexNumber} number for sun
    * @return {@link ComplexNumber} sun between numbers
    */
    public ComplexNumber sun(final ComplexNumber number){
        return ComplexNumber.sun(this, number);
    }

    /**
     * Returns a sun between two complex numbers
     * @param complexNumber1 {@link ComplexNumber} first member using by sun
     * @param complexNumber2 {@link ComplexNumber} second member using by sun
     * @return {@link ComplexNumber} sun between numbers
     */
    public static ComplexNumber sun(final ComplexNumber complexNumber1, final ComplexNumber complexNumber2){
        var realPart = complexNumber1.getRealPart() + complexNumber2.getRealPart();
        var imaginaryPart = complexNumber1.getImaginaryPart() + complexNumber2.getImaginaryPart();
        return new ComplexNumber(realPart, imaginaryPart);
    }

    @Override
    public String toString() {
        return String.format("%s + %si", this.realPart, this.imaginaryPart);
    }
}
