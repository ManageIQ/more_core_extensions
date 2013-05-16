require_relative "../../spec_helper"

describe String do
  context '#hex_dump' do
    let(:str) { "This is a test of the emergency broadcast system. This is only a test." }

    it "will handle exceptions" do
      lambda { "".hex_dump(1, 2) }.should raise_error(ArgumentError)
      lambda { "".hex_dump(:obj => STDOUT) }.should raise_error(ArgumentError)
      lambda { "".hex_dump(:meth => :puts) }.should raise_error(ArgumentError)
    end

    it 'with empty string' do
      "".hex_dump.should == ""
    end

    it 'with a short string' do
      "This is a test.".hex_dump.should == "0x00000000  54 68 69 73 20 69 73 20 61 20 74 65 73 74 2e     This is a test.\n"
    end

    it 'normal dump' do
      str.hex_dump.should == <<-EOL
0x00000000  54 68 69 73 20 69 73 20 61 20 74 65 73 74 20 6f  This is a test o
0x00000010  66 20 74 68 65 20 65 6d 65 72 67 65 6e 63 79 20  f the emergency\040
0x00000020  62 72 6f 61 64 63 61 73 74 20 73 79 73 74 65 6d  broadcast system
0x00000030  2e 20 54 68 69 73 20 69 73 20 6f 6e 6c 79 20 61  . This is only a
0x00000040  20 74 65 73 74 2e                                 test.
EOL
    end

    it 'passing object and method' do
      str_out = ''
      str.hex_dump(:obj => str_out, :meth => :<<)
      str_out.should == <<-EOL
0x00000000  54 68 69 73 20 69 73 20 61 20 74 65 73 74 20 6f  This is a test o
0x00000010  66 20 74 68 65 20 65 6d 65 72 67 65 6e 63 79 20  f the emergency\040
0x00000020  62 72 6f 61 64 63 61 73 74 20 73 79 73 74 65 6d  broadcast system
0x00000030  2e 20 54 68 69 73 20 69 73 20 6f 6e 6c 79 20 61  . This is only a
0x00000040  20 74 65 73 74 2e                                 test.
EOL
    end

    it 'passing :grouping => 8 option' do
      str.hex_dump(:grouping => 8).should == <<-EOL
0x00000000  54 68 69 73 20 69 73 20  This is\040
0x00000008  61 20 74 65 73 74 20 6f  a test o
0x00000010  66 20 74 68 65 20 65 6d  f the em
0x00000018  65 72 67 65 6e 63 79 20  ergency\040
0x00000020  62 72 6f 61 64 63 61 73  broadcas
0x00000028  74 20 73 79 73 74 65 6d  t system
0x00000030  2e 20 54 68 69 73 20 69  . This i
0x00000038  73 20 6f 6e 6c 79 20 61  s only a
0x00000040  20 74 65 73 74 2e         test.
EOL
    end

    it 'passing :newline => false option' do
      str.hex_dump(:newline => false).should == "0x00000000  54 68 69 73 20 69 73 20 61 20 74 65 73 74 20 6f  This is a test o0x00000010  66 20 74 68 65 20 65 6d 65 72 67 65 6e 63 79 20  f the emergency 0x00000020  62 72 6f 61 64 63 61 73 74 20 73 79 73 74 65 6d  broadcast system0x00000030  2e 20 54 68 69 73 20 69 73 20 6f 6e 6c 79 20 61  . This is only a0x00000040  20 74 65 73 74 2e                                 test."
    end

    it 'dumping every possible character' do
      expected = <<-EOL
0x00000000  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f  ................
0x00000010  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f  ................
0x00000020  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f   !\"\#$%&'()*+,-./
0x00000030  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f  0123456789:;<=>?
0x00000040  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
0x00000050  50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f  PQRSTUVWXYZ[\\]^_
0x00000060  60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f  `abcdefghijklmno
0x00000070  70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f  pqrstuvwxyz{|}~.
0x00000080  80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f  ................
0x00000090  90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f  ................
0x000000a0  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af  \240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257
0x000000b0  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf  \260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277
0x000000c0  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf  \300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317
0x000000d0  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df  \320\321\322\323\324\325\326\327\330\331\332\333\334\335\336\337
0x000000e0  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef  \340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357
0x000000f0  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff  \360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377
EOL

      str = ''
      0.upto(255) { |i| str << i.chr }
      str.hex_dump.should == expected
    end
  end
end