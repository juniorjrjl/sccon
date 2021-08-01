package br.com.sccon.challange;

import com.github.javafaker.Faker;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.Locale;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.assertj.core.api.Assertions.assertThat;

public class ComplexNumberTest {

    private final static Faker faker = new Faker(new Locale("pt-BR"));

    static Stream<Arguments> numbersPartNullTestData(){
        Long nullNumber = null;
        return Stream.of(
                Arguments.of(nullNumber, 0L),
                Arguments.of(0L, nullNumber)
        );
    }

    @ParameterizedTest(name = "using a follow number: {0} real, imaginary {1} throw a Exception")
    @MethodSource("numbersPartNullTestData")
    void numbersPartNullTest(final Long realPart, final Long imaginaryPart){
        assertThatThrownBy(() -> new ComplexNumber(realPart, imaginaryPart)).isInstanceOf(NullPointerException.class);
    }

    @Test
    void usingNoArgusConstructorTest(){
        var zeroComplexNumber = new ComplexNumber();
        assertThat(zeroComplexNumber.toString()).isEqualTo("0 + 0i");
        assertThat(zeroComplexNumber.getRealPart()).isZero();
        assertThat(zeroComplexNumber.getImaginaryPart()).isZero();
    }

    @Test
    void sunTwoComplexNumberTest(){
        var realNumber1 = faker.number().numberBetween(Long.MIN_VALUE, Long.MAX_VALUE);
        var imaginaryNumber1 = faker.number().numberBetween(Long.MIN_VALUE, Long.MAX_VALUE);
        var complexNumber1 = new ComplexNumber(realNumber1, imaginaryNumber1);
        var realNumber2 = faker.number().numberBetween(Long.MIN_VALUE, Long.MAX_VALUE);
        var imaginaryNumber2 = faker.number().numberBetween(Long.MIN_VALUE, Long.MAX_VALUE);
        var complexNumber2 = new ComplexNumber(realNumber2, imaginaryNumber2);
        var expectedRealNumber = realNumber1 + realNumber2;
        var expectedImaginaryNumber = imaginaryNumber1 + imaginaryNumber2;
        var actualComplexNumber = complexNumber1.sun(complexNumber2);
        assertThat(actualComplexNumber.getRealPart()).isEqualTo(expectedRealNumber);
        assertThat(actualComplexNumber.getImaginaryPart()).isEqualTo(expectedImaginaryNumber);
        assertThat(actualComplexNumber.toString()).isEqualTo(String.format("%s + %si", expectedRealNumber, expectedImaginaryNumber));
    }

}
