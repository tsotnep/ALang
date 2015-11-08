package com.nishtahir.value;

/**
 * Created by Nish on 11/7/15.
 */
public class StringValue extends Value<String> {

    public StringValue(String value) {
        this.value = value;
    }

    @Override
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }


    @Override
    public int compareTo(Value<String> o) {
        return this.value.compareTo(o.value);
    }
}