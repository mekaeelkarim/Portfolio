package autocomplete;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * Binary search implementation of the {@link Autocomplete} interface.
 *
 * @see Autocomplete
 */
public class BinarySearchAutocomplete implements Autocomplete {
    /**
     * {@link List} of added autocompletion terms.
     */
    private final List<CharSequence> terms;

    /**
     * Constructs an empty instance.
     */
    public BinarySearchAutocomplete() {
        this.terms = new ArrayList<>();
    }

    @Override
    public void addAll(Collection<? extends CharSequence> terms) {

        this.terms.addAll(terms);
        this.terms.sort(CharSequence::compare);
    }

    @Override
    public List<CharSequence> allMatches(CharSequence prefix) {

        List<CharSequence> result = new ArrayList<>();
        // return empty list if no prefix is given or prefix has no length
        if (prefix == null || prefix.length() == 0) {
            return result;
        }

        // finds first occurrence of given prefix
        int start = Collections.binarySearch(this.terms, prefix, CharSequence::compare);
        if (start < 0) {
            start = -(start+1);
        }

        // add terms to result starting at first occurrence of prefix and runs til the end of the list or when
        // the current term does not start with the prefix
        for(int i = start; i < terms.size(); i++) {
            if (terms.get(i).length() >= prefix.length()) {
                if (terms.get(i).subSequence(0, prefix.length()).equals(prefix)) {
                    result.add(terms.get(i));
                }
            }
            else {
                return result;
            }
        }

        return result;
    }
}
