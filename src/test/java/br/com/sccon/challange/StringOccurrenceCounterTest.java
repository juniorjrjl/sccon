package br.com.sccon.challange;

import com.github.javafaker.Faker;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.*;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;

public class StringOccurrenceCounterTest {

    private final static Faker faker = new Faker(new Locale("pt-BR"));

    static Stream<List<String>> noElementsTestData(){
        return Stream.of(null, new ArrayList<>());
    }

    @ParameterizedTest(name = "when using list [{0}] then return empty Map")
    @MethodSource("noElementsTestData")
    void noElementsTest(final List<String> names){
        var actual = StringOccurrenceCounter.count(names);
        assertThat(actual).isNotNull();
        assertThat(actual).isEmpty();
    }

    @Test
    void usingUniqueElementsTest(){
        final var uniqueNames = new HashSet<String>();
        while (uniqueNames.size() != 10){
            uniqueNames.add(faker.name().firstName());
        }
        final Map<String, Long> uniqueNamesMap = new HashMap<>();
        uniqueNames.forEach(s -> uniqueNamesMap.put(s ,1L));
        assertsNonNullList(new ArrayList<>(uniqueNames), uniqueNamesMap);
    }

    @Test
    void usingUpperCaseNames(){
        final var names = new ArrayList<String>();
        final var namesMap = new HashMap<String, Long>();
        var distinctNames = faker.number().numberBetween(5, 8);
        for (int j = 0; j < distinctNames; j++) {
            var occurrences = faker.number().numberBetween(2L, 7L);
            var name = faker.name().firstName();
            for (int i = 0; i < occurrences; i++) {
                var randomCaseName = faker.bool().bool() ? name.toUpperCase() : name.toLowerCase();
                if (i == 0){
                    namesMap.put(randomCaseName, occurrences);
                }
                names.add(randomCaseName);
            }
        }
        assertsNonNullList(names, namesMap);
    }

    @Test
    void usingNullAndEmptyNames(){
        final var names = new ArrayList<String>();
        final var namesMap = new HashMap<String, Long>();
        var nullName = faker.number().numberBetween(2, 8L);
        var emptyName = faker.number().numberBetween(2, 8L);
        for (int i = 0; i < nullName; i++) {
            names.add(null);
        }
        namesMap.put(null, nullName);
        for (int i = 0; i < emptyName; i++) {
            names.add("");
        }
        namesMap.put("", emptyName);
        assertsNonNullList(names, namesMap);
    }

    void assertsNonNullList(final List<String> names, final Map<String, Long> expect){
        var actual = StringOccurrenceCounter.count(names);
        assertThat(actual).isNotNull();
        assertThat(actual).isNotEmpty();
        assertThat(actual).containsExactlyInAnyOrderEntriesOf(expect);
    }

}
