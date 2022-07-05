package autocomplete;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Sequential search implementation of the {@link Autocomplete} interface.
 *
 * @see Autocomplete
 */
public class SequentialSearchAutocomplete implements Autocomplete {
    /**
     * {@link List} of added autocompletion terms.
     */
    private final List<CharSequence> terms;

    /**
     * Constructs an empty instance.
     */
    public SequentialSearchAutocomplete() {
        this.terms = new ArrayList<>();
    }

    @Override
    public void addAll(Collection<? extends CharSequence> terms) {
        // TODO: Replace with your code
        for (CharSequence curr : terms) {
            this.terms.add(curr);

        }
    }

    @Override
    public List<CharSequence> allMatches (CharSequence prefix){
        // TODO: Replace with your code
        List<CharSequence> result = new ArrayList<>();
        if (prefix == null || prefix.length() == 0) {
            return result;
        }
        for (CharSequence curr : terms) {
            if (curr.length() >= prefix.length() && curr.subSequence(0, prefix.length()).equals(prefix)) {
                result.add(curr);
            }
        }
        return result;

    }
}
