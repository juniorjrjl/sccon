package br.com.sccon.challange;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.text.Collator;
import java.util.*;

/**
 * A Utility Class to count String occurrences
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class StringOccurrenceCounter {

    /**
     * method using for compare two String values Case insensitive and ignoring accents
     * @param value1 String one using in compare
     * @param value2 String two using in compare
     * @return if string are equals or not.
     */
    private static boolean stringsAreEqualsIgnoreCaseAndAccents(final String value1, final String value2){
        var collator = Collator.getInstance();
        collator.setStrength(Collator.NO_DECOMPOSITION);
        var result = false;
        if (((value1 != null) && (value2 != null)) && (collator.compare(value1.toUpperCase(), value2.toUpperCase()) == 0)){
            result = true;
        } else {
            result = ((value1 == null) && (value2 == null));
        }
        return result;
    }

    /**
     * Count String occurrences in a list ignoring accents and Case Insensitive
     * ex.: [Maria, maria, MARIA, Mária, José, JOSE] will generate {Maria = 4, José = 2}
     * @param names list with Strings using for count
     * @return {@link Map} a map when a key is a name and value is a name occurrences in list
     * (a name used is a first name founded at list)
     */
    public static Map<String, Long> count(final List<String> names){
        final Map<String, Long> result = new HashMap<>();
        if ((names == null) || (names.isEmpty())){
            return result;
        }
        var countedPositions = new HashSet<Integer>();
        for (int i = 0; i < names.size(); i++) {
            if (!countedPositions.contains(i)){
                var countOccurrence = 1L;
                for (int j = 0; j < names.size(); j++) {
                    if ((i != j) && (!countedPositions.contains(j)) && (stringsAreEqualsIgnoreCaseAndAccents(names.get(i), names.get(j)))){
                        countOccurrence += 1;
                        countedPositions.add(j);
                    }
                }
                countedPositions.add(i);
                result.put(names.get(i), countOccurrence);
            }
        }
        return result;
    }

}
