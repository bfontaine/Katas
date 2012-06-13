#include "KataWordWrap.h"
#include <string>
#include <cppunit/TestFixture.h>
#include <cppunit/ui/text/TestRunner.h>
#include <cppunit/extensions/HelperMacros.h>

using namespace std;

class KataWordWrapTests : public CppUnit::TestFixture {

    CPPUNIT_TEST_SUITE(KataWordWrapTests);
    
    CPPUNIT_TEST(testEnoughColumns);
    CPPUNIT_TEST(testExactNumberOfColumns);
    CPPUNIT_TEST(testZeroColumns);
    CPPUNIT_TEST(testNotEnoughColumns);
    CPPUNIT_TEST(testBreakOnSpace);
    CPPUNIT_TEST(testBreakAfterSpace);

    CPPUNIT_TEST_SUITE_END();

    private:
        string *empty_s,
               *one_char,
               *two_words,
               *three_words,
               *one_sentence;
        
    public:
        void setUp() {
            empty_s      = new string("");
            one_char     = new string("a");
            two_words    = new string("hello world");
            three_words  = new string("hello big world");
            one_sentence = new string("Hello World, how are you?");
        }

        void tearDown() {
            delete empty_s;
            delete one_char;
            delete two_words;
            delete three_words;
            delete one_sentence;
        }

        void testEnoughColumns() {
            CPPUNIT_ASSERT(
                    empty_s->compare(Wrapper::wrap(empty_s, 42)) == 0);
            CPPUNIT_ASSERT(
                    one_char->compare(Wrapper::wrap(one_char, 42)) == 0);
            CPPUNIT_ASSERT(
                    two_words->compare(Wrapper::wrap(two_words, 42)) == 0);
            CPPUNIT_ASSERT(
                    three_words->compare(Wrapper::wrap(three_words, 42)) == 0);
            CPPUNIT_ASSERT(
                    one_sentence->compare(Wrapper::wrap(one_sentence, 42)) == 0);
        }

        void testExactNumberOfColumns() {
            CPPUNIT_ASSERT(
                    empty_s->compare(Wrapper::wrap(empty_s, 0)) == 0);
            CPPUNIT_ASSERT(
                    one_char->compare(Wrapper::wrap(one_char, 1)) == 0);
            CPPUNIT_ASSERT(
                    two_words->compare(Wrapper::wrap(two_words,
                                                    two_words->length())) == 0);
            CPPUNIT_ASSERT(
                    three_words->compare(Wrapper::wrap(three_words,
                                                       three_words->length())) == 0);
            CPPUNIT_ASSERT(
                    one_sentence->compare(Wrapper::wrap(one_sentence,
                                                       one_sentence->length())) == 0);
        }

        void testZeroColumns() {
            CPPUNIT_ASSERT(
                    empty_s->compare(Wrapper::wrap(empty_s, 0)) == 0);
            CPPUNIT_ASSERT(
                    one_char->compare(Wrapper::wrap(one_char, 0)) == 0);
            CPPUNIT_ASSERT(
                    two_words->compare(Wrapper::wrap(two_words, 0)) == 0);
            CPPUNIT_ASSERT(
                    three_words->compare(Wrapper::wrap(three_words, 0)) == 0);
            CPPUNIT_ASSERT(
                    one_sentence->compare(Wrapper::wrap(one_sentence, 0)) == 0);
        }

        void testNotEnoughColumns() {
            CPPUNIT_ASSERT(
                    two_words->compare(Wrapper::wrap(two_words, 3)) == 0);
            CPPUNIT_ASSERT(
                    three_words->compare(Wrapper::wrap(three_words, 4)) == 0);
            CPPUNIT_ASSERT(
                    one_sentence->compare(Wrapper::wrap(one_sentence, 2)) == 0);
        }

        void testBreakOnSpace() {
            CPPUNIT_ASSERT(
                    Wrapper::wrap(two_words, 5).compare("hello\nworld") == 0);
        }

        void testBreakAfterSpace() {
            CPPUNIT_ASSERT(
                 Wrapper::wrap(two_words, 7).compare("hello\nworld") == 0);
            CPPUNIT_ASSERT(
                 Wrapper::wrap(three_words, 7).compare("hello\nbig\nworld") == 0);
        }

};

CPPUNIT_TEST_SUITE_REGISTRATION(KataWordWrapTests);

int main() {
    
    CppUnit::TextUi::TestRunner runner;
    runner.addTest( KataWordWrapTests::suite() );
    runner.run();

    return 0;
}
