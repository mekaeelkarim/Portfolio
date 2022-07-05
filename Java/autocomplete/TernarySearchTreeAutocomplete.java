package autocomplete;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Ternary search tree (TST) implementation of the {@link Autocomplete} interface.
 *
 * @see Autocomplete
 */
public class TernarySearchTreeAutocomplete implements Autocomplete {
    /**
     * The overall root of the tree: the first character of the first autocompletion term added to this tree.
     */
    private Node overallRoot;
    private int size;

    /**
     * Constructs an empty instance.
     */
    public TernarySearchTreeAutocomplete() {
        overallRoot = null;
    }

    @Override
    public void addAll(Collection<? extends CharSequence> terms) {
        for (CharSequence curr: terms) {
            add(curr);
        }

    }

    @Override
    public List<CharSequence> allMatches(CharSequence prefix) {
        List<CharSequence> result = new ArrayList<>();
        if (prefix == null || prefix.length() == 0) {
            return result;
        }
        Node node = get(overallRoot, prefix, 0);
        if (node != null) {
            if (node.isTerm) {
                result.add(prefix);
            }
            collect(node.mid, new StringBuilder(prefix), result);
        }
        return result;
    }

    /**
     * Method that begins the process of adding a new word to the TST
    */
    private void add(CharSequence key) {
        if (key == null) {
            throw new NullPointerException("calls add() with null key");
        }
        if (!contains(key)) {
            overallRoot = add(overallRoot, key, 0);
            size += 1;
        }
    }

    // Private helper method for adding a node if it doesn't already exist in the TST.
    private Node add(Node node, CharSequence key, int depth) {
        char curr = key.charAt(depth);
        if (node == null) {
            node = new Node(curr, false);
        }
        if (curr < node.data) {
            // if curr comes alphabetically before node.data, traverse down the left subtree
            node.left = add(node.left, key, depth);
        } else if (curr > node.data) {
            // if curr comes alphabetically after node.data, traverse down the right subtree
            node.right = add(node.right, key, depth);
        } else if (depth < key.length() - 1) {
            // if curr is the correct letter, and not at the end of the tree, traverse down the middle subtree
            node.mid = add(node.mid, key, depth + 1);
        } else {
            // if at the end of the tree path, ensure isTerm is true
            node.isTerm = true;
        }
        return node;
    }

    /** Returns true if and only if this TST contains the given key. */
    private boolean contains(CharSequence key) {
        if (key == null) {
            throw new NullPointerException("calls contains() with null argument");
        } else if (key.length() == 0) {
            throw new IllegalArgumentException("key must have length >= 1");
        }
        Node node = get(overallRoot, key, 0);
        return node != null && node.isTerm;
    }

    // Private helper method for returning the node (subtree) corresponding to given key
    private Node get(Node node, CharSequence key, int depth) {
        if (node == null) {
            return null;
        }
        char curr = key.charAt(depth);
        if (curr < node.data) {
            // if curr comes before node.data, traverse down the left subtree
            return get(node.left, key, depth);
        } else if (curr > node.data) {
            // if curr comes after node.data, traverse down the right subtree
            return get(node.right, key, depth);
        } else if (depth < key.length() - 1) {
            // if curr is the correct letter, and not at the end of the tree, traverse down the middle subtree
            return get(node.mid, key, depth + 1);
        } else {
            // if at the end of the tree path, return the current letter
            return node;
        }
    }

    // Private helper method for collecting all keys in the node (subtree) with the given prefix
    private void collect(Node node, StringBuilder prefix, List<CharSequence> list) {
        if (node == null) {
            return;
        }
        collect(node.left, prefix, list);
        if (node.isTerm) {
            list.add(prefix.toString() + node.data);
        }
        prefix.append(node.data);
        collect(node.mid, prefix, list);
        prefix.deleteCharAt(prefix.length() - 1);
        collect(node.right, prefix, list);
    }
    /**
     * A search tree node representing a single character in an autocompletion term.
     */
    private static class Node {
        private char data;
        private boolean isTerm;
        private Node left;
        private Node mid;
        private Node right;

        public Node(char data, boolean isTerm) {
            this.data = data;
            this.isTerm = isTerm;
            this.left = null;
            this.mid = null;
            this.right = null;
        }
    }
}
